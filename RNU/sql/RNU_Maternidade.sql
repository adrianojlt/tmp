
-- IinId disponivel na pagina pesquisaUtente.jsp, mapeado no 'pesquisaUtentePageDef.xml'
-- Este valor é passado por ajax, o paremetro da query para receber este valor é o 'IDU_INSCR_ID'

-- select *
 select 
 SYS_USERS_PERFIS.SYS_USERS_ID,
 IDU_INSCR.ID,  		IDU_INSCR.SYS_ENTIDADES_ID, 
 IDU_INSCR.DTA_INSC, 	IDU_INSCR.DATA_INI, 		IDU_INSCR.DATA_FIM, IDU_INSCR.CREATION_DATE, IDU_INSCR.LAST_UPDATE_DATE 
from SYS_USERS_PERFIS, IDU_INSCR
where SYS_USERS_PERFIS.SYS_ENTIDADES_ID = IDU_INSCR.SYS_ENTIDADES_ID_MATERNIDADE 
and IDU_INSCR.ID = 17298778 -- IDU_INSCR_ID
and SYS_PERFIS_ID = (
	select ID from SYS_PERFIS where PERFIL = '380' and ID_APP = (
		select ID from SYS_COD_GENERICOS where CODIGO ='RNU' 
		and DATA_INACTIVO is null 
		and SYS_TIPOS_CODIGOS_ID = ( 
			select ID from SYS_TIPOS_CODIGOS where SYS_TIPOS_CODIGOS.COD_TIPO ='APLC' 
		)
	)
);

select * from IDU_INSCR where id = 17298778;
select * from SYS_ENTIDADES where id = 230763;
select * from SYS_USERS_PERFIS;

select * from sys_users where id in (26,44241,44242,44661); -- 26 administrador_piloto
select * from SYS_ENTIDADES where id = 230763;
select * from sys_users_perfis where sys_entidades_id = 230763;

-- adriano jose leite adicionado na maternidade dia 15 maio ...
select * from IDU_IDENT_UT where ID = (select IDU_IDENT_UT_ID from IDU_INSCR where ID = 17298778);