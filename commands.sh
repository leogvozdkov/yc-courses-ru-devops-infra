export HELM_EXPERIMENTAL_OCI=1
helm pull oci://cr.yandex/yc-marketplace/crossplane/crossplane/crossplane --untar --untardir=charts --version=1.6.3-5

# Создаем сервисный аккаунт для crossplane и выдаем права
yc iam service-account create --name crossplane

yc resource-manager folder add-access-binding \
  --name=default \
  --service-account-name=crossplane \
  --role=admin

yc iam key create --service-account-name crossplane --output sa-key.json

export SOPS_AGE_KEY_FILE=$(pwd)/key.txt
export SOPS_AGE_RECIPIENTS=<публичный ключ>
