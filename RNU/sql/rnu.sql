

-- PERFIS --
select * from SYS_PERFIS;
select * from SYS_PERFIS 		where PERFIL  	= '250'; -- supervisor
select * from SYS_PERFIS 		where PERFIL  	< '251'; -- supervisores ou superior
select * from SYS_PERFIS        where PERFIL  	= '380' and id_app = '215553'; -- Perfil maternidade do RNU
select * from SYS_PERFIS        where PERFIL  	= '376' and id_app = '215553'; -- Perfil hospital do RNU
select * from SYS_PERFIS        where PERFIL  	= '380' and id_app = '215533'; -- Perfil de consulta do CIT
select * from SYS_COD_GENERICOS where ID   		= '215553'; -- RNU
select * from SYS_COD_GENERICOS where ID 		= '215533'; -- CIT

-- UTENTE
select * from IDU_IDENT_UT;
select * from IDU_INSCR where idu_ident_ut_id = (select id from idu_ident_ut where nir = '998761216');
select * from IDU_IDENT_UT 		where nir 		= '998761216'; -- adicionado a 15 de maio

-- inscricao do utente com o nir 998761216 -- adriano jose leite  -> data nasc: 15 - 5 - 2014
select * from IDU_INSCR where id = 17298778; 

-- IinId = 17298778 a ser passado por ajax ...
select * from sys_users_perfis, idu_inscr
where sys_users_perfis.SYS_ENTIDADES_ID = idu_inscr.sys_entidades_id_maternidade and idu_inscr.id = 17298778
and SYS_perfis_id = (select id from SYS_PERFIS where PERFIL = '380' and id_app = (select id from sys_cod_genericos 
  where codigo ='RNU' and 
  data_inactivo is null and 
  sys_tipos_codigos_id = ( select id from sys_tipos_codigos where sys_tipos_codigos.cod_tipo ='APLC' )));

-- update realizado ... a clausula 'id = 10000520' é pa ser retirada na passagem a producao ....
update SYS_OPCOES_PERFIS 
	set SYS_OPCOES_MENU_ID = (select id from sys_opcoes_menu where NOME = 'JSP_IDU_MU') 
	where 	SYS_OPCOES_MENU_ID 	= (select id from sys_opcoes_menu where NOME = 'JSP_IDU_CU' and id = 10000520)
	and 	SYS_PERFIS_ID 		= (
		select id from SYS_PERFIS where perfil = '380' 
		and id_app = (select id from sys_cod_genericos where codigo ='RNU' and 
  data_inactivo is null and 
  sys_tipos_codigos_id = ( select id from sys_tipos_codigos where sys_tipos_codigos.cod_tipo ='APLC' )) );  

select * from sys_users where id in (44241,26,44242);

select * from IDU_INSCR where idu_ident_ut_id = (select id from idu_ident_ut where nir = '998761216');
select * from IDU_INSCR where sys_entidades_id = '2148';
select * from SYS_ENTIDADES where id = '2148';

select * from sys_users;
select * from sys_users where nome like '%adriano%';
select * from sys_users_perfis;
select * from sys_users_perfis where sys_perfis_id in (select id from SYS_PERFIS where perfil = '380' and id_app = '215533');
select * from sys_users_perfis where sys_perfis_id in (select id from SYS_PERFIS where perfil = '380' and id_app = '215553');

-- TMP
select * from SYS_PERFIS where perfil  < '251';
select * from sys_users;
select * from SYS_ENTIDADES where designacao like '%HOSPITAL PRIVADO DOS LUSÍADAS%';
select * from SYS_ENTIDADES WHERE id = '1003';


select * from sys_opcoes_perfis;
select * from sys_opcoes_perfis where sys_perfis_id = 266;
select * from sys_opcoes_menu where NOME = 'JSP_IDU_MU';
select * from sys_opcoes_menu where NOME = 'JSP_IDU_CU';
select * from sys_opcoes_menu where id = 10000520;

update SYS_OPCOES_PERFIS set SYS_OPCOES_MENU_ID = (select id from sys_opcoes_menu where NOME = 'JSP_IDU_MU') 
where SYS_OPCOES_MENU_ID = (select id from sys_opcoes_menu where NOME = 'JSP_IDU_CU' and id = 10000520);


select * from sys_cod_genericos 
  where codigo ='RNU' and 
  data_inactivo is null and 
  sys_tipos_codigos_id = ( select id from sys_tipos_codigos where sys_tipos_codigos.cod_tipo ='APLC' );


-- maternidade do hospital privado dos lusiadas


select * from SYS_PERFIS, sys_users_perfis where sys_users_perfis.sys_perfis_id = sys_perfis.id;
