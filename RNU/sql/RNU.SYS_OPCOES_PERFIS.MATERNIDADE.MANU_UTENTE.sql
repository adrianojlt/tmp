-- update realizado ... a clausula 'id = 10000520' é pa ser retirada na passagem a producao ....
update SYS_OPCOES_PERFIS set SYS_OPCOES_MENU_ID = (select ID from SYS_OPCOES_MENU where NOME = 'JSP_IDU_MU')
	where	SYS_OPCOES_MENU_ID 	= (
		select ID from SYS_OPCOES_MENU where NOME = 'JSP_IDU_CU' and ID = 10000520
	)
	and		SYS_PERFIS_ID 		= (
		select ID from SYS_PERFIS 
		where PERFIL = '380' 
		and id_app = (
			select ID from SYS_COD_GENERICOS where CODIGO ='RNU' 
			and DATA_INACTIVO is null 
			and SYS_TIPOS_CODIGOS_ID = ( 
				select ID from SYS_TIPOS_CODIGOS where SYS_TIPOS_CODIGOS.COD_TIPO ='APLC' 
			)
		)
	);

-- the same as above
update SYS_OPCOES_PERFIS set SYS_OPCOES_MENU_ID = (select id from sys_opcoes_menu where NOME = 'JSP_IDU_MU') where 	SYS_OPCOES_MENU_ID 	= (select id from sys_opcoes_menu where NOME = 'JSP_IDU_CU' and id = 10000520) and 	SYS_PERFIS_ID 		= (select id from SYS_PERFIS where perfil = '380'and id_app = (select id from sys_cod_genericos where codigo ='RNU' and data_inactivo is null and sys_tipos_codigos_id = ( select id from sys_tipos_codigos where sys_tipos_codigos.cod_tipo ='APLC' )) );

