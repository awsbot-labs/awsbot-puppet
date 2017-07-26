release: git
	
git:
	@git status
	@echo "Enter commit message:"
	@read REPLY; \
	git add --all; \
	git commit -m "$$REPLY"; \
	git push --set-upstream origin $(shell git rev-parse --abbrev-ref HEAD)
	git push	
