REM INSERTING into SYS_ENTIDADES
SET DEFINE OFF;
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('ID','NUMBER','No',null,1,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CODIGO','NUMBER(7,0)','Yes',null,2,'Codigo do centro de saude.');
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CODIGO_ANTIGO','VARCHAR2(23 CHAR)','Yes',null,3,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('DESIGNACAO','VARCHAR2(500 BYTE)','Yes',null,4,'Designac?o do centro de saude.');
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('DESC_ABRV','VARCHAR2(30 CHAR)','Yes',null,5,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('TELEFONE','VARCHAR2(30 BYTE)','Yes',null,6,'Telefone do centro de saude.');
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('COD_AUX_01','VARCHAR2(15 CHAR)','Yes',null,7,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('COD_AUX_02','VARCHAR2(15 CHAR)','Yes',null,8,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('COD_AUX_03','VARCHAR2(15 CHAR)','Yes',null,9,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('COD_AUX_05','VARCHAR2(15 CHAR)','Yes',null,10,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('COD_AUX_04','VARCHAR2(15 CHAR)','Yes',null,11,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('MORADA','VARCHAR2(400 CHAR)','Yes',null,12,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('URL','VARCHAR2(255 CHAR)','Yes',null,13,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('PATH_IMAGEM','VARCHAR2(100 CHAR)','Yes',null,14,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('SYS_TIPOS_CODIGOS_ID','NUMBER','Yes',null,15,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('SYS_SUBTIPO_ENTIDADES_ID','NUMBER','Yes',null,16,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('SYS_ENTIDADES_ID','NUMBER','Yes',null,17,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('ACTIVO','VARCHAR2(1 CHAR)','No','''S'' ',18,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('DATA_ACTIVO','DATE','No',null,19,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('DATA_INACTIVO','DATE','Yes',null,20,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CREATED_BY','VARCHAR2(30 CHAR)','No',null,21,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CREATION_DATE','DATE','No',null,22,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('LAST_UPDATED_BY','VARCHAR2(30 CHAR)','No',null,23,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('LAST_UPDATE_DATE','DATE','No',null,24,null);
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('SYS_COD_HIER_ID','NUMBER','Yes',null,25,'ID da freguesia da morada postal da entidade (unidade saude)');
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('SYS_CODIGO_POSTAL_ID','NUMBER','Yes',null,26,'ID do codigo postal da morada da entidade (caso deja conhecido)');
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('SCG_TIPO_UNIFUNCIONAL_ID','NUMBER','Yes',null,27,'ID do Tipo da Unidade Funcional da Entidades (Unid. Funcional Transversal / Especifia)');
Insert into SYS_ENTIDADES (COLUMN_NAME,DATA_TYPE,NULLABLE,DATA_DEFAULT,COLUMN_ID,COMMENTS) values ('CODIGO_ALFANUMERICO','VARCHAR2(50 CHAR)','Yes',null,28,null);