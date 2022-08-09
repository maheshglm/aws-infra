locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  customer_vars    = read_terragrunt_config(find_in_parent_folders("customer.hcl"))
  customer_name    = local.customer_vars.locals.customer_name
  environment_name = local.environment_vars.locals.environment
  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_region       = local.region_vars.locals.aws_region
  project_name     = "wordpress"
  name_prefix      = format("%s-%s", local.project_name, local.environment_name)
}

terraform {
  source = "../../../../../../../modules//autoscaling_group/v6.5.0"
}

include {
  path = find_in_parent_folders()
}

dependency "unique_id" {
  config_path = "../../unique_id"
}

dependency "vpc" {
  config_path = "../../vpc"
}

dependency "lb" {
  config_path = "../lb"
}

dependency "asg_sg" {
  config_path = "../asg_sg"
}

dependency "keypair" {
  config_path = "../asg_keypair"
}

dependency "mysql" {
  config_path = "../mysql"
}

inputs = {
  project     = local.project_name
  environment = local.environment_name

  //unique_id = dependency.unique_id.outputs.id

  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  health_check_type   = "ELB"
  vpc_zone_identifier = dependency.vpc.outputs.private_subnets
  target_group_arns   = dependency.lb.outputs.target_group_arns
  use_name_prefix     = true

  image_id      = "ami-0960ab670c8bb45f3"
  instance_type = "t2.micro"
  user_data     = <<-EOF
                #!/bin/bash
                # AUTOMATIC WORDPRESS INSTALLER IN  AWS Ubuntu Server 20.04 LTS (HVM)

                # varaible will be populated by terraform template
                db_username="${dependency.mysql.outputs.db_instance_username}"
                db_user_password="${dependency.mysql.outputs.db_instance_password}"
                db_name="${dependency.mysql.outputs.db_instance_name}"
                db_RDS="${dependency.mysql.outputs.service_endpoint_single}"

                # install LAMP Server
                apt update  -y
                apt upgrade -y
                apt update  -y
                apt upgrade -y
                #install apache server
                apt install -y apache2
                apt install -y php
                apt install -y php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,bcmath,json,xml,intl,zip,imap,imagick}

                #and download mysql package to yum  and install mysql client from yum
                apt install -y mysql-client-core-8.0

                # starting apache  and register them to startup

                systemctl enable --now  apache2


                # Change OWNER and permission of directory /var/www
                usermod -a -G www-data ubuntu
                chown -R ubuntu:www-data /var/www
                find /var/www -type d -exec chmod 2775 {} \;
                find /var/www -type f -exec chmod 0664 {} \;

                # #**********************Installing Wordpress manually*********************************
                # # Download wordpress package and extract
                # wget https://wordpress.org/latest.tar.gz
                # tar -xzf latest.tar.gz
                # cp -r wordpress/* /var/www/html/
                # # Create wordpress configuration file and update database value
                # cd /var/www/html
                # cp wp-config-sample.php wp-config.php
                # sed -i "s/database_name_here/$db_name/g" wp-config.php
                # sed -i "s/username_here/$db_username/g" wp-config.php
                # sed -i "s/password_here/$db_user_password/g" wp-config.php
                # sed -i "s/localhost/$db_RDS/g" wp-config.php
                # cat <<EOF >>/var/www/html/wp-config.php
                # define( 'FS_METHOD', 'direct' );
                # define('WP_MEMORY_LIMIT', '128M');
                # EOF

                #**********************Installing Wordpress using WP CLI*********************************

                curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
                chmod +x wp-cli.phar
                mv wp-cli.phar /usr/local/bin/wp
                wp core download --path=/var/www/html --allow-root
                wp config create --dbname=$db_name --dbuser=$db_username --dbpass=$db_user_password --dbhost=$db_RDS --path=/var/www/html --allow-root --extra-php <<PHP
                define( 'FS_METHOD', 'direct' );
                define('WP_MEMORY_LIMIT', '128M');
                PHP

                # Change permission of /var/www/html/
                chown -R ubuntu:www-data /var/www/html
                chmod -R 774 /var/www/html
                rm /var/www/html/index.html
                #  enable .htaccess files in Apache config using sed command
                sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf
                a2enmod rewrite

                # restart apache

                systemctl restart apache2
                echo "WordPress Installed"
                EOF

  #  user_data = templatefile("user-data.sh.tpl", {
  #    db_username      = dependency.mysql.outputs.db_instance_username
  #    db_user_password = dependency.mysql.outputs.db_instance_password
  #    db_name          = dependency.mysql.outputs.db_instance_name
  #    db_RDS           = dependency.mysql.outputs.service_endpoint_single
  #  })

  security_groups = dependency.asg_sg.outputs.security_group_ids
  key_name        = dependency.keypair.outputs.key_name
}