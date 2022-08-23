#!/bin/bash

current_dir="$(pwd)"

read -p "Enter base path relative to the live folder [ex: live-4/commons/vpc/base]: " base_path
base_path="$base_path"

read -p "Enter terraform action [init|plan|apply|destroy], Defaults to [plan]: " action
action="${action:-plan}"

read -p "Enter environment name [dev|prod|stg], Defaults to [dev]: " env
env="${env:-dev}"

read -p "Should auto-approve ? [y/N], Defaults to [y]: " auto_approve
auto_approve=${auto_approve:-"y"}

auto_approve_result=""
if [[ $auto_approve == "y" ]]; then
  auto_approve_result="-auto-approve"
fi

echo -e "\n\nrunning terraform $action from relative path ${base_path}......\n"

pushd $(pwd) 1>/dev/null

cd "${current_dir}/../${base_path}" || exit

if [[ $action == "init" ]]; then
  terraform init
  popd 1>/dev/null
  exit 0
fi

if [[ $action == "apply" || $action == "destroy" ]]; then
  echo -e "terraform ${action} ${auto_approve_result} -var-file ../env/${env}/terraform.tfvars\n"
  terraform ${action} ${auto_approve_result} -var-file ../env/${env}/terraform.tfvars

  cp terraform.tfstate ${env}.terraform.tfstate 2>/dev/null

else
  echo -e "terraform ${action} -var-file ../env/${env}/terraform.tfvars\n"
  terraform ${action} -var-file ../env/${env}/terraform.tfvars
fi

popd 1>/dev/null
