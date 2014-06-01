REM INSERTING into SYS_COD_GENERICOS
SET DEFINE OFF;
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('ID','NUMBER','No',null,1,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CODIGO','VARCHAR2(50 CHAR)','No',null,2,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CODIGO_ANTIGO','VARCHAR2(23 CHAR)','Yes',null,3,'coluna para efeitos de mapeamento de codigo na migrac?o / sincronizac?o');
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('DESCRICAO','VARCHAR2(400 BYTE)','No',null,4,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('DESC_ABRV','VARCHAR2(50 CHAR)','Yes',null,5,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('ORDENACAO','NUMBER','Yes',null,6,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('LIMITE_MIN','NUMBER','Yes',null,7,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('LIMITE_MAX','NUMBER','Yes',null,8,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('ACTIVO','VARCHAR2(1 CHAR)','No','''S'' ',9,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('DATA_ACTIVO','DATE','No','SYSDATE ',10,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('DATA_INACTIVO','DATE','Yes',null,11,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('OBSERVACOES','VARCHAR2(250 CHAR)','Yes',null,12,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('SYS_TIPOS_CODIGOS_ID','NUMBER','No',null,13,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('SYS_ENTIDADES_ID','NUMBER','Yes',null,14,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CREATED_BY','VARCHAR2(30 CHAR)','No',null,15,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CREATION_DATE','DATE','No',null,16,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('LAST_UPDATED_BY','VARCHAR2(30 CHAR)','No',null,17,null);
Insert into SYS_COD_GENERICOS (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('LAST_UPDATE_DATE','DATE','No',null,18,null);