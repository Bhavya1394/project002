help:   ##Print this message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
cart:     ## Install Cart component
	@echo Installing Cart
catalogue:  ##Install Catalogue component
	@echo Installing Catalogue
frontend:   ##Install Frontend component
	@echo Installing Frontend
MongoDB:    ##Install MongoDB component
	@echo Installing MongoDB
MySQL:     ## Install MySQL component
	@echo Installing MySQL
payment:    ## Install Payment component
	@echo Installing Payment
RabbitMQ:   ## Install RabbitMQ component
	@echo Installing RabbitMQ
redis:     ## Install Redis component
	@echo Installing Redis
shipping:   ## Install Shipping component
	@echo Installing Shipping
User:     ## Install User component
	@echo Installing User
databases: ## Install All Databases
databases: mongodb mysql rabbitmq redis