all:
	$(source /usr/caen/oracle/local/muscle)
	sqlplus
	createTables.sql
	dropTables.sql
