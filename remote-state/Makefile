init:
	terraform init

plan:
	terraform init
	terraform plan -out tfplan.out

apply:
	terraform apply tfplan.out

destroy:
	terraform destroy

clean:
	rm -rf .terraform 
