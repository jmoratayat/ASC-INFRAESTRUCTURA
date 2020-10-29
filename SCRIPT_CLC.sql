create database if not exists db_clc;
use db_clc;
#CONSULTAS-INTELIGENTES----------------------------------------------------------------------------
create table if not exists CONSULTA_INTELIGENTE (
  pk_id_consulta_inteligente 					int not null,
  nombre_consulta_inteligente 					varchar(100) null,
  contenido_consulta_inteligente 				varchar(250) null,
  primary key (pk_id_consulta_inteligente)
);
alter table CONSULTA_INTELIGENTE change pk_id_consulta_inteligente pk_id_consulta_inteligente int(11) not null auto_increment;
#SEGURIDAD-----------------------------------------------------------------------------------------
create table if not exists LOGIN(
	pk_id_login 						int(10) not null primary key auto_increment,
    usuario_login 						varchar(45),
    contraseña_login 					varchar(45),
    nombreCompleto_login				varchar(100),
    estado_login						int(2)
);
create table if not exists MODULO(
	pk_id_modulo 						int(10)not null auto_increment,
    nombre_modulo 						varchar(30)not null,
    descripcion_modulo 					varchar(50)not null,
    estado_modulo 						int(1)not null,
    primary key(pk_id_modulo),
    key(pk_id_modulo)
);
create table if not exists APLICACION(
	pk_id_aplicacion 					int(10)not null auto_increment,
    fk_id_modulo 						int(10)not null,
    nombre_aplicacion 					varchar(40)not null,
    descripcion_aplicacion 				varchar(45)not null,
    estado_aplicacion 					int(1)not null,
    primary key(pk_id_aplicacion),
    key(pk_id_aplicacion)
);
alter table APLICACION add constraint fk_aplicacion_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);

create table if not exists PERFIL(
	pk_id_perfil						int(10) not null primary key auto_increment,
    nombre_perfil						varchar(50),
    descripcion_perfil					varchar(100),
    estado_perfil						int(2)
);
create table if not exists PERMISO(
	pk_id_permiso						int(10) not null primary key auto_increment,
    insertar_permiso					boolean,
    modificar_permiso					boolean,
    eliminar_permiso					boolean,
    consultar_permiso					boolean,
    imprimir_permiso					boolean
);
create table if not exists APLICACION_PERFIL(
	pk_id_aplicacion_perfil				int(10) not null primary key auto_increment,
    fk_idaplicacion_aplicacion_perfil	int(10),
    fk_idperfil_aplicacion_perfil		int(10),
    fk_idpermiso_aplicacion_perfil		int(10)
);
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_aplicacion foreign key (fk_idaplicacion_aplicacion_perfil) references APLICACION(pk_id_aplicacion)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_perfil foreign key (fk_idperfil_aplicacion_perfil) references PERFIL(pk_id_perfil)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_permiso foreign key (fk_idpermiso_aplicacion_perfil) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists PERFIL_USUARIO(
	pk_id_perfil_usuario				int(10) not null primary key auto_increment,
    fk_idusuario_perfil_usuario			int(10),
    fk_idperfil_perfil_usuario			int(10)
);
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_login foreign key(fk_idusuario_perfil_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_perfil foreign key (fk_idperfil_perfil_usuario) references PERFIL(pk_id_perfil) on delete restrict on update cascade;

create table if not exists APLICACION_USUARIO(
	pk_id_aplicacion_usuario			int(10) not null primary key auto_increment,
    fk_idlogin_aplicacion_usuario		int(10),
    fk_idaplicacion_aplicacion_usuario	int(10),
    fk_idpermiso_aplicacion_usuario		int(10)
);
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_login foreign key(fk_idlogin_aplicacion_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_aplicacion foreign key (fk_idaplicacion_aplicacion_usuario) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_permiso foreign key(fk_idpermiso_aplicacion_usuario) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists BITACORA(
	pk_id_bitacora						int(10) not null primary key auto_increment, #pk
    fk_idusuario_bitacora				int(10),
    fk_idaplicacion_bitacora			int(10),
    fechahora_bitacora					varchar(50),
    direccionhost_bitacora				varchar(20),
    nombrehost_bitacora					varchar(20),
    accion_bitacora						varchar(250)
);
CREATE TABLE IF NOT EXISTS DETALLE_BITACORA (
    pk_id_detalle_bitacora 				INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_idbitacora_detalle_bitacora 		INT(10),
    querryantigua_detalle_bitacora 		VARCHAR(50),
    querrynueva_detalle_bitacora 		VARCHAR(50)
);
alter table BITACORA add constraint fk_login_bitacora foreign key (fk_idusuario_bitacora) references LOGIN (pk_id_login) on delete restrict on update cascade;
alter table BITACORA add constraint fk_aplicacion_bitacora foreign key (fk_idaplicacion_bitacora) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table DETALLE_BITACORA add constraint fk_bitacora_detallebitacora foreign key(fk_idbitacora_detalle_bitacora) references BITACORA(pk_id_bitacora) on delete restrict on update cascade;

#REPORTEADOR---------------------------------------------------------------------------------------
create table if not exists REPORTE(
	pk_id_reporte int(10)not null auto_increment,
    nombre_reporte varchar(40)not null,
    ruta_reporte varchar(100)not null,
    estado_reporte int(1)not null,
    primary key(pk_id_reporte),
    key(pk_id_reporte)
);
create table if not exists REPORTE_MODULO(
	fk_id_reporte int(10)not null ,
    fk_id_modulo int(10)not null,
    estado_reporte_modulo int(1)not null,
    primary key(fk_id_reporte,fk_id_modulo),
    key(fk_id_reporte,fk_id_modulo)
);
alter table REPORTE_MODULO add constraint fk_reporte_de_modulo foreign key(fk_id_reporte) references REPORTE(pk_id_reporte);
alter table REPORTE_MODULO add constraint fk_reporte_de_modulo_reportes foreign key(fk_id_modulo) references MODULO(pk_id_modulo);

create table if not exists REPORTE_APLICATIVO(
	fk_id_reporte int(10)not null,
    fk_id_aplicacion int(10)not null,
    fk_id_modulo int(10)not null,
    estado_reporte_aplicativo int(1)not null,
    primary key(fk_id_reporte,fk_id_aplicacion,fk_id_modulo),
    key(fk_id_reporte,fk_id_aplicacion,fk_id_modulo)
);
alter table REPORTE_APLICATIVO add constraint fk_reporte_aplicativo_reporte foreign key(fk_id_reporte) references REPORTE(pk_id_reporte);
alter table REPORTE_APLICATIVO add constraint fk_reporte_aplicativo_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);
alter table REPORTE_APLICATIVO add constraint fk_report_aplicativo foreign key(fk_id_aplicacion) references APLICACION(pk_id_aplicacion);

##MODULOS------------------------------------------------------------------------------------------
###HRM---------------------------------------------------------------------------------------------
create table if not exists GENERO (
  pk_id_genero 									int not null,
  nombre_genero 								varchar(45) null,
  primary key (pk_id_genero)
  );
create table if not exists ESTADO_CIVIL (
  pk_id_estado_civil 							int not null,
  nombre_estado_civil 							varchar(45) null,
  primary key (pk_id_estado_civil)
);  
create table if not exists LICENCIA_CONDUCCION (
  pk_id_licencia_conduccion 					int not null,
  tipo_licencia_conduccion 						varchar(45) null,
  primary key (pk_id_licencia_conduccion)
);
create table if not exists HORARIO (
  pk_id_horario 								int not null,
  nombre_horario 								varchar(45) null,
  descripcion_horario 							varchar(45) null,
  primary key (pk_id_horario)
);
create table if not exists PUESTO (
  pk_id_puesto 									int not null,
  nombre_puesto 								varchar(45) null,
  salario_puesto 								double,
  fk_id_horario_puesto 							int null,
  primary key (pk_id_puesto)
);
alter table PUESTO add constraint fk_horario_puesto foreign key (fk_id_horario_puesto) references HORARIO (pk_id_horario) on delete restrict on update cascade;

create table if not exists DEPARTAMENTO_EMPRESARIAL (
  pk_id__departamento_empresarial 				int not null,
  nombre_departamento_empresarial 				varchar(150) null,
  primary key (pk_id__departamento_empresarial)
);
create table if not exists EMPLEADO (
  pk_id_empleado 								int not null,
  nombre1_empleado 								varchar(45) null,
  nombre2_empleado 								varchar(45) null,
  apellido1_empleado 							varchar(45) null,
  apellido2_empleado 							varchar(45) null,
  fecha_nacimiento_empleado 					varchar(10) null,
  dpi_empleado 									int null,
  fk_id_genero_empleado 						int null,
  fk_id_estado_civil_empleado 					int null,
  email_empleado 								varchar(125) null,
  telefono_empleado 							int null,
  numero_iggs_empleado							int null,
  fk_id_licencia_conducir_empleado 				int null,
  fk_id_puesto_empleado 						int null,
  cuenta_bancaria_empleado 						int null,
  fk_id_departamento_empresarial_empleado 		int null,
  estado_empleado 								int null,
  primary key (pk_id_empleado)
);
alter table EMPLEADO add constraint fk_genero_empleado1 foreign key (fk_id_genero_empleado) references GENERO(pk_id_genero) on delete restrict on update cascade;
alter table EMPLEADO add constraint fk_estado_civil_empleado foreign key (fk_id_estado_civil_empleado) references ESTADO_CIVIL (pk_id_estado_civil) on delete restrict on update cascade; 
alter table EMPLEADO add constraint fk_licencia_conducir_empleado foreign key (fk_id_licencia_conducir_empleado) references LICENCIA_CONDUCCION (pk_id_licencia_conduccion) on delete restrict on update cascade;
alter table EMPLEADO add constraint fk_puesto_empleado foreign key (fk_id_puesto_empleado) references PUESTO (pk_id_puesto) on delete restrict on update cascade; 
alter table EMPLEADO add constraint fk_departamento_empresarial_empleado foreign key (fk_id_departamento_empresarial_empleado) references DEPARTAMENTO_EMPRESARIAL (pk_id__departamento_empresarial) on delete restrict on update cascade; 

create table if not exists TIPO_BAJA(
	pk_id_tipo_baja								int not null,
    nombre_tipo_baja							varchar(10),
    primary key(pk_id_tipo_baja)
);
create table if not exists BAJA(
	pk_id_baja									int not null,
    fk_id_empleado_baja							int null,
    fk_id_tipo_baja								int null,
    prestaciones_baja							double null,
    tiempo_laborado_baja						int null,
    fecha_despido_baja							varchar(10),
    causa_bajas							varchar(200),
    primary key(pk_id_baja)
);
alter table BAJA add constraint fk_bajas_empleado foreign key (fk_id_empleado_baja) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table BAJA add constraint fk_tipo_bajas foreign key (fk_id_tipo_baja) references TIPO_BAJA (pk_id_tipo_baja) on delete restrict on update cascade;

create table if not exists ASCENSO(
	pk_id_ascenso								int not null,
    fk_id_empleado_ascenso						int null,
    fecha_ascenso								varchar(10),
    fk_puesto_anterior_ascenso					int not null,
    fk_departamento_anterior_ascenso			int null,
    salario_anterior_ascenso					double null,
    fk_puesto_nuevo_ascenso						int null,
    fk_departamento_nuevo_ascenso				int null,
    salario_nuevo_ascenso						double null,
    primary key(pk_id_ascenso)
);
alter table ASCENSO add constraint fk_ascenso_empleado foreign key (fk_id_empleado_ascenso) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table ASCENSO add constraint fk_ascenso_puesto_anterior foreign key (fk_puesto_anterior_ascenso) references PUESTO (pk_id_puesto) on delete restrict on update cascade;
alter table ASCENSO add constraint fk_ascenso_depto_anterior foreign key (fk_departamento_anterior_ascenso) references DEPARTAMENTO_EMPRESARIAL (pk_id__departamento_empresarial) on delete restrict on update cascade; 
alter table ASCENSO add constraint fk_ascenso_puesto_nuevo foreign key (fk_puesto_nuevo_ascenso) references PUESTO (pk_id_puesto) on delete restrict on update cascade;
alter table ASCENSO add constraint fk_ascenso_depto_nuevo foreign key (fk_departamento_nuevo_ascenso) references DEPARTAMENTO_EMPRESARIAL (pk_id__departamento_empresarial) on delete restrict on update cascade;

create table if not exists CURSO (
  pk_id_curso 									int not null,
  nombre_curso 									varchar(45) null,
  capacitador_curso 							varchar(45) null,
  primary key (pk_id_curso)
  );
create table if not exists ENCABEZADO_CAPACITACION (
  pk_id_encabezado_capacitacion 				int not null,
  nombre_encabezado_capacitacion 				varchar(45) null,
  fecha_inicio_encabezado_capacitacion 			varchar(10) null,
  fecha_fin_encabezado_capacitacion 			varchar(10) null,
  fk_id_curso_encabezado_capacitacion 			int null,
  primary key (pk_id_encabezado_capacitacion)
);
alter table ENCABEZADO_CAPACITACION add constraint fk_curso_encabezado_capacitacion foreign key (fk_id_curso_encabezado_capacitacion) references CURSO (pk_id_curso) on delete restrict on update cascade;

create table if not exists ENCABEZADO_COMPETENCIA(
	pk_id_encabezado_competencia				int not null,
    fk_id_empleado_encabezado_competencia		int null,
    fecha_inicio_encabezado_competencia			varchar(10)null,
    fecha_fin_encabezado_competencia			varchar(10)null,
    primary key(pk_id_encabezado_competencia)
);
alter table ENCABEZADO_COMPETENCIA add constraint fk_empleado_encabezado_competencia foreign key (fk_id_empleado_encabezado_competencia) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade; 

create table if not exists TIPO_COMPETENCIA (
  pk_id_tipo_competencia 						int not null,
  nombre_competencia 							varchar(150) null,
  primary key (pk_id_tipo_competencia)
);
create table if not exists COMPETENCIA_DESARROLLO (
  pk_id_competencia_desarrollo 					int not null,
  fk_id_encabezado_competencia 					int not null,
  fk_id_tipo_competencia_desarrollo		 		int null,
  resultado_competencia_desarrollo			 	int null,
  primary key (pk_id_competencia_desarrollo)
);
alter table COMPETENCIA_DESARROLLO add constraint fk_encabezado_competencia foreign key (fk_id_encabezado_competencia) references ENCABEZADO_COMPETENCIA (pk_id_encabezado_competencia) on delete restrict on update cascade; 
alter table COMPETENCIA_DESARROLLO add constraint fk_tipo_competencia_desarrollo foreign key (fk_id_tipo_competencia_desarrollo) references TIPO_COMPETENCIA (pk_id_tipo_competencia) on delete restrict on update cascade; 

create table if not exists FORMACION_ACADEMICA (
  pk_id_formacion_academica 					int not null,
  nombre_formacion_academica 					varchar(50) null,
  primary key (pk_id_formacion_academica)
);
create table if not exists TIPO_ENTREVISTA (
  pk_id_tipo_entrevista 						int not null,
  nombre_tipo_entrevista 						varchar(45) null,
  primary key (pk_id_tipo_entrevista)
);
create table if not exists RECLUTAMIENTO (
  pk_id_reclutamiento 							int not null,
  fk_id_nivel_estudio_reclutamiento		 		int null,
  nombre1_reclutamiento 						varchar(45) null,
  nombre2_reclutamiento 						varchar(45) null,
  apellido1_reclutamiento 						varchar(45) null,
  apellido2_reclutamiento 						varchar(45) null,
  fecha_nacimiento_reclutamiento 				varchar(10) null,
  dpi_reclutamiento 							int null,
  fk_id_genero_reclutamiento 					int null,
  fk_id_estado_civil_reclutamiento 				int null,
  email_reclutamiento 							varchar(125) null,
  telefono_reclutamiento 						int null,
  numero_igss_reclutamiento						int null,
  fk_id_licencia_conducir_reclutamiento 		int null,
  fk_id_puesto_reclutamiento 					int null,
  estado_reclutado_entrevista 					int null,
  nombre_profesion								varchar(125),
  fk_id_departamento_empresarial_reclutamiento 	int null,
  primary key (pk_id_reclutamiento)
);
alter table RECLUTAMIENTO add constraint fk_nivel_estudio_reclutamiento foreign key (fk_id_nivel_estudio_reclutamiento) references FORMACION_ACADEMICA (pk_id_formacion_academica) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_genero_reclutamiento foreign key (fk_id_genero_reclutamiento) references GENERO (pk_id_genero) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_estado_civil_reclutamiento foreign key (fk_id_estado_civil_reclutamiento) references ESTADO_CIVIL (pk_id_estado_civil) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_licencia_conducir_reclutamiento foreign key (fk_id_licencia_conducir_reclutamiento) references LICENCIA_CONDUCCION (pk_id_licencia_conduccion) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_puesto_reclutamiento foreign key (fk_id_puesto_reclutamiento) references PUESTO (pk_id_puesto) on delete restrict on update cascade;
alter table RECLUTAMIENTO add constraint fk_departamento_empresarial_reclutamiento foreign key (fk_id_departamento_empresarial_reclutamiento) references DEPARTAMENTO_EMPRESARIAL (pk_id__departamento_empresarial) on delete restrict on update cascade;

create table if not exists DIRECCION(
	pk_id_direccion 							int not null,
    departamento_direccion 						varchar(45),
    zona_direccion 								varchar(7),
    municipio_direccion 						varchar(100),
    residencia_direccion						varchar(45),
    fk_empleado_direccion						int null,
    fk_reclutamiento_direccion					int null,
    primary key(pk_id_direccion)
);
alter table DIRECCION add constraint fk_empleado_direccion foreign key (fk_empleado_direccion) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table DIRECCION add constraint fk_reclutamiento_direccion foreign key (fk_reclutamiento_direccion) references RECLUTAMIENTO (pk_id_reclutamiento) on delete restrict on update cascade;

create table if not exists CAPACITACION (
  pk_id_capacitacion 							int not null,
  fk_id_encabezado_capacitacion 				int null,
  fk_id_empleado_capacitacion 					int null,
  resultado_capacitacion 						varchar(5) null,
  primary key (pk_id_capacitacion)
);
alter table CAPACITACION add constraint fk_encabezado_capacitacion foreign key (fk_id_encabezado_capacitacion) references ENCABEZADO_CAPACITACION (pk_id_encabezado_capacitacion) on delete restrict on update cascade;
alter table CAPACITACION add constraint fk_empleado_capacitacion foreign key (fk_id_empleado_capacitacion) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;

create table if not exists FALTA (
  pk_id_falta 									int not null,
  nombre_falta 									varchar(45) null,
  descripción_falta 							varchar(45) null,
  primary key (pk_id_falta)
);
create table if not exists FALTA_EMPLEADO (
  pk_id_falta_empleado 							int not null,
  fk_id_empleado_falta_empleado 				int null,
  fk_id_tipo_falta_empleado 					int null,
  fecha_falta_empleado 							varchar(10) null
);
alter table FALTA_EMPLEADO add constraint fk_empleado_falta foreign key (fk_id_empleado_falta_empleado)references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table FALTA_EMPLEADO add constraint fk_tipo_falta foreign key (fk_id_tipo_falta_empleado) references FALTA (pk_id_falta) on delete restrict on update cascade;

create table if not exists ENCABEZADO_NOMINA (
  pk_id_encabezado_nomina 						int not null,
  nombre_encabezado_nomina 						varchar(45) null,
  fecha_inicio_encabezado_nomina 				varchar(10) null,
  fecha_fin_encabezado_nomina 					varchar(10) null,
  primary key (pk_id_encabezado_nomina)
);
create table if not exists PERCEPCION (
  pk_id_percepcion 								int not null,
  nombre_percepcion 							varchar(45) null,
  monto_percepcion 								double null,
  descripcion_percepcion 						varchar(150) null,
  primary key (pk_id_percepcion)
);
create table if not exists DEDUCCION (
  pk_id_deduccion 								int not null,
  nombre_deduccion 								varchar(45) null,
  monto_deduccion 								double null,
  descripcion_deduccion 						varchar(150) null,
  primary key (pk_id_deduccion)
);
create table if not exists DETALLE_NOMINA (
  pk_id_detalle_nomina 							int not null,
  fk_id_encabezado_detalle_nomina 				int null,
  fk_id_empleado_detalle_nomina 				int null,
  fk_id_percepciones_detalle_nomina 			int null,
  fk_id_deducciones_detalle_nomina 				int null,
  salario_base_detalle_nomina 					double null,
  primary key (pk_id_detalle_nomina)
);
alter table DETALLE_NOMINA add constraint fk_encabezado_detalle_nomina foreign key (fk_id_encabezado_detalle_nomina) references ENCABEZADO_NOMINA (pk_id_encabezado_nomina) on delete restrict on update cascade;
alter table DETALLE_NOMINA add constraint fk_emplado_detalle_nomina foreign key (fk_id_empleado_detalle_nomina) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table DETALLE_NOMINA add constraint fk_percepcion_detalle_nomina foreign key (fk_id_percepciones_detalle_nomina) references PERCEPCION (pk_id_percepcion) on delete restrict on update cascade;
alter table DETALLE_NOMINA add constraint fk_deduccion_detalle_nomina foreign key (fk_id_deducciones_detalle_nomina) references DEDUCCION (pk_id_deduccion) on delete restrict on update cascade;

create table if not exists ENTREVISTA (
  pk_id_entrevista 								int not null,
  fk_id_empleado_entrevista 					int null,
  fk_id_reclutamiento_entrevista 				int null,
  fk_id_tipo_entrevista 						int null,
  resultado_entrevista 							int null,
  comentarios_entrevistador_entrevista 			varchar(200) null,
  primary key (pk_id_entrevista)
);
alter table ENTREVISTA add constraint fk_empleado_entrevista foreign key (fk_id_empleado_entrevista) references EMPLEADO (pk_id_empleado) on delete restrict on update cascade;
alter table ENTREVISTA add constraint fk_reclutamiento_entrevista foreign key (fk_id_reclutamiento_entrevista) references RECLUTAMIENTO (pk_id_reclutamiento) on delete restrict on update cascade;
alter table ENTREVISTA add constraint fk_tipo_entrevista foreign key (fk_id_tipo_entrevista) references TIPO_ENTREVISTA (pk_id_tipo_entrevista) on delete restrict on update cascade;

###FRM---------------------------------------------------------------------------------------------
create table if not exists BANCO (
pk_id_banco 						int(11) NOT NULL,
nombre_banco 						varchar(50) ,
estado_banco 						tinyint(4)
);
alter table BANCO add primary key (pk_id_banco);

create table if not exists TIPO_MONEDA (
pk_id_tipo_moneda 					int(11) not null,
moneda_tipo_moneda 					varchar(45),
simbolo_tipo_moneda 				varchar(2),
descripcion_tipo_moneda				varchar(75) ,
estado_tipo_moneda 					tinyint(4)
);
alter table TIPO_MONEDA add primary key (pk_id_tipo_moneda);

create table if not exists PROPIETARIO(
pk_id_propietario 					int(11) not null,
nombre_propietario 					varchar(45),
descripcion_propietario 			varchar(75),
estado_propietario 					tinyint(4)
);
alter table PROPIETARIO add primary key (pk_id_propietario);

create table if not exists CUENTA_BANCARIA (
pk_id_numero_cuenta_bancaria 		int(11) not null,
fk_id_banco 						int(11) not null,
fk_id_propietario 					int(11) not null,
fk_id_tipo_moneda 					int(11) not null,
saldo_cuenta_bancaria 				double,
fecha_apertura_cuenta_bancaria 		datetime,
estado_apertura_cuenta_bancaria 	tinyint(4)
);
alter table CUENTA_BANCARIA add primary key (pk_id_numero_cuenta_bancaria),add key fk_cuenta_bancaria_banco (fk_id_banco), add key fk_cuenta_bancaria_propietario (fk_id_propietario), add key fk_cuenta_bancaria_tipomoneda (fk_id_tipo_moneda);
alter table CUENTA_BANCARIA add constraint fk_cuenta_bancaria_banco foreign key (fk_id_banco) references BANCO (pk_id_banco)on delete no action on update no action;
alter table CUENTA_BANCARIA add constraint fk_cuenta_bancaria_propietario foreign key (fk_id_propietario) references PROPIETARIO (pk_id_propietario)on delete no action on update no action;
alter table CUENTA_BANCARIA add constraint fk_cuenta_bancaria_tipomoneda foreign key (fk_id_tipo_moneda) references TIPO_MONEDA (pk_id_tipo_moneda)on delete no action on update no action;

create table if not exists TIPO_CUENTA_CONTABLE (
pk_id_tipo_cuenta_contable 			int(11) not null,
nombre_tipo_cuenta_contable 		varchar(75)
);
alter table TIPO_CUENTA_CONTABLE add primary key(pk_id_tipo_cuenta_contable);

create table if not exists CUENTA_CONTABLE(
pk_id_cuenta_contable 				int(11) not null,
nombre_cuenta_contable 				varchar(75),
nivel_cuenta_contable 				int(11) ,
fk_cuenta_padre_cuenta_contable 	int(11) NOT NULL,
saldo_anterior_cuenta_contable 		double ,
saldo_actual_cuenta_contable 		double ,
cargo_mes_cuenta_contable 			double ,
abono_mes_cuenta_contable 			double ,
cargo_acumulado_cuenta_contable 	double ,
abono_acumulado_cuenta_contable 	double ,
estado_cuenta_contable 				tinyint(4) ,
fk_id_tipo_cuenta_contable 			int(11) not null
);
alter table CUENTA_CONTABLE add primary key (pk_id_cuenta_contable), add key fk_cuenta_padre_cuenta_hijo (fk_cuenta_padre_cuenta_contable), add key fk_tipo_cuenta_cuenta_contable (fk_id_tipo_cuenta_contable);
alter table CUENTA_CONTABLE add constraint fk_cuenta_padre_cuenta_hijo foreign key (fk_cuenta_padre_cuenta_contable) references CUENTA_CONTABLE(pk_id_cuenta_contable)on delete no action on update no action;
alter table CUENTA_CONTABLE add constraint fk_tipo_cuenta_contable foreign key (fk_id_tipo_cuenta_contable) references TIPO_CUENTA_CONTABLE(pk_id_tipo_cuenta_contable)on delete no action on update no action;

create table if not exists TIPO_TRANSACCION (
pk_id_tipo_transaccion 				int(11) not null,
nombre_tipo_transaccion 			varchar(45) ,
descripcion_tipo_transaccion 		varchar(75) ,
estado_tipo_transaccion 			tinyint(4)
) ;
alter table TIPO_TRANSACCION add primary key (pk_id_tipo_transaccion);

create table if not exists TRANSACCION (
pk_id_transaccion 					int(11) not null,
fk_id_numero_cuenta_bancaria 		int(11) not null,
fecha_transaccion 					datetime ,
fk_id_tipo_transaccion 				int(11) not null,
fk_id_tipo_moneda 					int(11) not null,
monto_transaccion 					double ,
descripcion_transaccion 			varchar(75)
) ;
alter table TRANSACCION add primary key (pk_id_transaccion), add key fk_transaccion_numero_cuenta (fk_id_numero_cuenta_bancaria), 
add key fk_transaccion_tipo_transaccion (fk_id_tipo_transaccion), add key fk_transaccion_tipo_moneda (fk_id_tipo_moneda);
alter table TRANSACCION add constraint fk_encabezado_transaccion_numero_cuenta foreign key (fk_id_numero_cuenta_bancaria) references CUENTA_BANCARIA (pk_id_numero_cuenta_bancaria)on delete no action on update no action;
alter table TRANSACCION add constraint fk_transaccion_tipo_transaccion foreign key (fk_id_tipo_transaccion) references TIPO_TRANSACCION (pk_id_tipo_transaccion)on delete no action on update no action;

create table if not exists SALDO_HISTORICO (
pk_id_cuenta_contable 				int(11) not null,
pk_fecha_saldo_historico 			datetime not null,
monto_saldo_historico 				double
);
alter table SALDO_HISTORICO add primary key (pk_id_cuenta_contable, pk_fecha_saldo_historico);
alter table SALDO_HISTORICO add constraint fk_saldo_cuenta_contable foreign key (pk_id_cuenta_contable) references CUENTA_CONTABLE (pk_id_cuenta_contable)on delete no action on update no action;


create table if not exists POLIZA_ENCABEZADO (
pk_poliza_encabezado 				int(11) not null,
fecha_poliza_encabezado 			datetime,
descripcion_poliza_encabezado 		varchar(75) ,
estado_poliza_encabezado 			tinyint(4) ,
total_poliza_encabezado 			double
);
alter table POLIZA_ENCABEZADO add primary key (pk_poliza_encabezado);

create table if not exists POLIZA_DETALLE (
pk_poliza_encabezado 				int(11) not null,
pk_id_cuenta_contable 				int(11) NOT NULL,
monto_poliza_detalle 				double ,
debe_poliza_detalle 				tinyint(4)
);
alter table POLIZA_DETALLE add primary key (pk_poliza_encabezado,pk_id_cuenta_contable);
alter table POLIZA_DETALLE add constraint fk_poliza_detalle_poliza_encabezado foreign key (pk_poliza_encabezado) references POLIZA_ENCABEZADO (pk_poliza_encabezado)on delete no action on update no action;
alter table POLIZA_DETALLE add constraint fk_poliza_detalle_cuenta foreign key (pk_id_cuenta_contable) references CUENTA_CONTABLE (pk_id_cuenta_contable)on delete no action on update no action;

create table if not exists PETICION_POLIZA(
pk_id_peticion_poliza 				int(11) not null,
concepto_peticion_poliza 			varchar(30),
fecha_peticion_poliza 				datetime,
descripcion_peticion_poliza 		varchar(100),
monto_peticion_poliza 				double,
fk_pk_poliza_encabezado 			int(11)
);
alter table PETICION_POLIZA add primary key (pk_id_peticion_poliza);

create table if not exists BALANCE_ENCABEZADO (
pk_id_balance_encabezado 					int(11) not null,
descripcion_balance_encabezado 				varchar(75) ,
fecha_creacion_balance_encabezado 			datetime ,
total_debe_haber_balance_encabezado 		double ,
total_deudor_acreedor_balance_encabezado 	double
);
alter table BALANCE_ENCABEZADO add primary key (pk_id_balance_encabezado);

create table if not exists BALANCE_DETALLE (
pk_id_balance_encabezado 			int(11) not null,
pk_id_cuenta_contable 				int(11) not null,
debe_balance_detalle 				double ,
haber_balance_detalle 				double ,
deudor_balance_detalle 				double ,
acreedor_balance_detalle 			double
) ;
alter table BALANCE_DETALLE add primary key (pk_id_balance_encabezado), add key fk_balance_detalle_cuenta (pk_id_cuenta_contable);
alter table BALANCE_DETALLE add constraint fk_balance_encabezado_detalle foreign key (pk_id_balance_encabezado) references BALANCE_ENCABEZADO (pk_id_balance_encabezado)on delete no action on update no action;
alter table BALANCE_DETALLE add constraint fk_balance_detalle_cuenta_contable foreign key (pk_id_cuenta_contable) references CUENTA_CONTABLE (pk_id_cuenta_contable)on delete no action on update no action;

###SCM---------------------------------------------------------------------------------------------
create table DEPARTAMENTO(
	pk_id_departamento int(10)not null auto_increment,
    nombre_departamento varchar(30)not null,
    descripcion_departamento varchar(45)not null,
    estado_departamento int(1)not null,
    primary key(pk_id_departamento),
    key(pk_id_departamento)
);
create table MUNICIPIO(
	pk_id_municipio int(10)not null auto_increment,
    fk_id_departamento int(10)not null,
    nombre_municipio varchar(30)not null,
    descripcion_municipio varchar(45)not null,
    estado_municipio int(1)not null,
    primary key(pk_id_municipio),
    key(pk_id_municipio)
);
alter table MUNICIPIO add constraint fk_municipio_departamento foreign key(fk_id_departamento) references DEPARTAMENTO(pk_id_departamento);

create table BODEGA(
	pk_id_bodega int(10)not null auto_increment,
    fk_id_municipio int(10)not null,
    descripcion_bodega varchar(45)not null,
    dimensiones_bodega double(5,2)not null,
    direccion_bodega varchar(45)not null,
    telefono_bodega int(8)not null,
    estado_bodega int(1)not null,
    primary key(pk_id_bodega),
    key(pk_id_bodega)
);
alter table BODEGA add constraint fk_bodega_municipio foreign key(fk_id_municipio) references MUNICIPIO(pk_id_municipio);

create table LINEA_PRODUCTO(
	pk_id_linea_producto int(10)not null auto_increment,
    nombre_linea_producto varchar(25)not null,
    descripcion_linea_producto varchar(50) not null,
    estado_linea_producto int(1) not null,
    primary key(pk_id_linea_producto),
    key(pk_id_linea_producto)
);
create table CATEGORIA_PRODUCTO(
	pk_id_categoria_producto int(10) not null auto_increment,
    nombre_categoria_producto varchar(35)not null,
    descripcion_categoria_producto varchar(60)not null,
    estado_categoria_producto int(1)not null,
    primary key(pk_id_categoria_producto),
    key(pk_id_categoria_producto)
);
create table PRODUCTO(
	pk_id_producto int(10)not null auto_increment,
    fk_id_linea_producto int(10)not null,
    fk_id_categoria_producto int(10)not null,
    nombre_producto varchar(50)not null,
    precio_producto double(12,2)not null,
    medida_producto double(5,2)not null,
    descripcion_producto varchar(45)not null,
    estado_producto int(1)not null,
    primary key(pk_id_producto),
    key(pk_id_producto)
);
alter table PRODUCTO add constraint fk_producto_lineaProducto foreign key(fk_id_linea_producto) references LINEA_PRODUCTO(pk_id_linea_producto);
alter table PRODUCTO add constraint fk_producto_categoriaProducto foreign key(fk_id_categoria_producto) references CATEGORIA_PRODUCTO(pk_id_categoria_producto);

create table EXISTENCIA(
	pk_id_existencia int(10)not null auto_increment,
    fk_id_bodega int(10)not null,
    fk_id_producto int(10)not null,
    cantidad_existencia int(10)not null,
    estado_existencia int(1)not null,
    primary key(pk_id_existencia),
    key(pk_id_existencia)
);
alter table EXISTENCIA add constraint fk_inventario_producto foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);
alter table EXISTENCIA add constraint fk_inventario_bodega foreign key(fk_id_bodega) references BODEGA(pk_id_bodega);

create table INVENTARIO(
	pk_id_inventario int(10)not null auto_increment,
    fk_id_producto int(10)not null,
    cantidad_inventario int(10)not null,
    estado_inventario int(1)not null,
    primary key(pk_id_inventario),
    key(pk_id_inventario)
);
alter table INVENTARIO add constraint fk_total_inventario foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);

create table PAIS(
	pk_id_pais int(10)not null auto_increment,
    nombre_pais varchar(40)not null,
    capital_pais varchar(40)not null,
    estado_pais int(1)not null,
    primary key(pk_id_pais),
    key(pk_id_pais)
);
create table PROVEEDOR(
	pk_id_proveedor int(10)not null auto_increment,
    fk_id_pais int(10)not null,
    razon_social_proveedor varchar(45)not null,
    representante_legal_proveedor varchar(45) not null,
    nit_proveedor varchar(20)not null,
    estado_proveedor int(1)not null,
    primary key(pk_id_proveedor),
    key(pk_id_proveedor)
);
alter table PROVEEDOR add constraint fk_proveedor_pais foreign key(fk_id_pais) references PAIS(pk_id_pais);

create table TELEFONO_PROVEEDOR(
	pk_id_telefono_proveedor int(10)not null auto_increment,
    fk_id_proveedor int(10)not null,
    telefono_telefono_proveedor varchar(20)not null,
    primary key(pk_id_telefono_proveedor),
    key(pk_id_telefono_proveedor)
);
alter table TELEFONO_PROVEEDOR add constraint fk_proveedor_telefono foreign key(fk_id_proveedor) references PROVEEDOR(pk_id_proveedor);

create table CORREO_PROVEEDOR(
	pk_id_correo_proveedor int(10)not null auto_increment,
    fk_id_proveedor int(10)not null,
    correo_correo_proveedor varchar(50)not null,
    primary key(pk_id_correo_proveedor),
    key(pk_id_correo_proveedor)
);
alter table CORREO_PROVEEDOR add constraint fk_proveedor_correo foreign key(fk_id_proveedor) references PROVEEDOR(pk_id_proveedor);

create table ENCARGADO_BODEGA(
	pk_id_encargado_bodega int(10)not null auto_increment,
    fk_id_empleado int(10)not null,
    fk_id_bodega int(10)not null,
    estado_encargado_bodega int(1)not null,
    primary key(pk_id_encargado_bodega),
    key(pk_id_encargado_bodega)
);
alter table ENCARGADO_BODEGA add constraint fk_empleado_bodega foreign key(fk_id_bodega) references BODEGA(pk_id_bodega);

create table COMPRA_ENCABEZADO(
	pk_id_compra_encabezado int(10)not null,
    fk_id_proveedor int(10)not null,
    fec_compra_encabezado_compra datetime not null,
    total_compra_encabezado_compra double(12,2) not null,
    estado_encabezado_compra int(1)not null,
    primary key(pk_id_compra_encabezado),
    key(pk_id_compra_encabezado)
);
alter table COMPRA_ENCABEZADO add constraint fk_compra_proveedor foreign key(fk_id_proveedor) references PROVEEDOR(pk_id_proveedor);

create table COMPRA_DETALLE(
	fk_id_compra_encabezado int(10)not null,
	cod_linea_compra_detalle int(10)not null,
    fk_id_producto int(10)not null,
    cantidad_compra_detalle int(10)not null,
    precio_unitario_compra_detalle double(8,2)not null,
    subtotal_compra_detalle double(12,2)not null,
    estado_compra_detalle int(1)not null,
    primary key(fk_id_compra_encabezado,cod_linea_compra_detalle),
    key(fk_id_compra_encabezado,cod_linea_compra_detalle)
);
alter table COMPRA_DETALLE add constraint fk_compra_detalle foreign key(fk_id_compra_encabezado) references COMPRA_ENCABEZADO(pk_id_compra_encabezado);
alter table COMPRA_DETALLE add constraint fk_compra_producto foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);

create table FABRICA(
	pk_id_fabrica int(10)not null auto_increment,
    fk_id_municipio int(10)not null,
    dimensiones_fabrica double(5,2)not null,
    direccion_fabrica varchar(45)not null,
    telefono_fabrica int(8)not null,
    descripcion_fabrica varchar(45)not null,
    estado_fabrica int(1)not null,
    primary key(pk_id_fabrica),
    key(pk_id_fabrica)
);
alter table FABRICA add constraint fk_fabrica_municipio foreign key(fk_id_municipio) references MUNICIPIO(pk_id_municipio);

create table PEDIDO_ENCABEZADO(
	pk_id_pedido_encabezado int(10)not null,
    fk_id_fabrica int(10)not null,
    fec_pedido_pedido_encabezado datetime not null,
    total_pedido_encabezado double(12,2) not null,
    estado_pedido_encabezado int(1)not null,
    primary key(pk_id_pedido_encabezado),
    key(pk_id_pedido_encabezado)
);
alter table PEDIDO_ENCABEZADO add constraint fk_pedido_fabrica foreign key(fk_id_fabrica) references FABRICA(pk_id_fabrica);

create table PEDIDO_DETALLE(
	fk_id_pedido_encabezado int(10)not null,
	cod_linea_pedido_detalle int(10)not null,
    fk_id_producto int(10)not null,
    cantidad_pedido_detalle int(10)not null,
    precio_unitario_pedido_detalle double(8,2)not null, /*Precio dado por fábrica*/
    subtotal_pedido_detalle double(12,2)not null,
    estado_pedido_detalle int(1)not null,
    primary key(fk_id_pedido_encabezado,cod_linea_pedido_detalle),
    key(fk_id_pedido_encabezado,cod_linea_pedido_detalle)
);
alter table PEDIDO_DETALLE add constraint fk_encabezado_pedido foreign key(fk_id_pedido_encabezado) references PEDIDO_ENCABEZADO(pk_id_pedido_encabezado);
alter table PEDIDO_DETALLE add constraint fk_pedido_producto foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);

create table MARCA (
	pk_id_marca int(10)not null auto_increment,
	descripcion_marca varchar(45)not null,
	estado_marca int(1)not null,
	primary key(pk_id_marca),
	key(pk_id_marca)
);
create table VEHICULO (
  pk_id_vehiculo int(10)not null auto_increment,
  fk_id_marca int (10) not null,
  placa_vehiculo varchar(45)not null,
  modelo_vehiculo varchar(45)not null,
  color_vehiculo varchar(45)not null,
  anio_vehiculo  varchar(45)not null,
  tipo_combustible_vehiculo varchar(45)not null,
  estado_vehiculo int(1)not null,
  primary key(pk_id_vehiculo),
  key(pk_id_vehiculo)
);
alter table VEHICULO add constraint fk_vehiculo_marca foreign key(fk_id_marca) references MARCA (pk_id_marca);

create table RUTA(
	pk_id_ruta int(10)not null auto_increment,
    origen_ruta varchar(40) not null,
    destino_ruta varchar(40)not null,
    descripcion_ruta varchar(45)not null,
    estado_ruta int(1)not null,
    primary key(pk_id_ruta),
    key(pk_id_ruta)
);
create table TIPO_MOVIMIENTO(
	pk_id_tipo_movimiento int(10)not null,
    nombre_tipo_movimiento varchar(45)not null,
    signo_tipo_movimiento varchar(1),
	primary key(pk_id_tipo_movimiento),
    key(pk_id_tipo_movimiento)
);
create table MOVIMIENTO_INVENTARIO(
	pk_id_movimiento_inventario int(10)not null,
    fecha_movimiento_inventario datetime not null,
    fk_id_tipo_movimiento int(10)not null,
    fk_id_ruta int(10) not null,
    fk_id_vehiculo int(10)not null,
    documento_asociado_movimiento_inventario int(10)not null,
    descripcion_movimiento_inventario varchar(50) not null,
	primary key(pk_id_movimiento_inventario),
    key(pk_id_movimiento_inventario)
);
alter table MOVIMIENTO_INVENTARIO add constraint fk_mov_inventario_tipo foreign key(fk_id_tipo_movimiento) references TIPO_MOVIMIENTO(pk_id_tipo_movimiento);
alter table MOVIMIENTO_INVENTARIO add constraint fk_mov_inventario_ruta foreign key(fk_id_ruta) references RUTA(pk_id_ruta);
alter table MOVIMIENTO_INVENTARIO add constraint fk_mov_inventario_vehiculo foreign key(fk_id_vehiculo) references VEHICULO(pk_id_vehiculo);

create table MOVIMIENTO_INVENTARIO_DETALLE(
	pk_id_movimiento_inventario_detalle int(10)not null,
    fk_id_movimiento_inventario int(10)not null,
    fk_id_producto int(10)not null,
	cantidad_inventario_detalle int(8)not null,
	primary key(pk_id_movimiento_inventario_detalle),
    key(pk_id_movimiento_inventario_detalle)
);
alter table MOVIMIENTO_INVENTARIO_DETALLE add constraint fk_mov_inventario_detalle_mov foreign key(fk_id_movimiento_inventario) references MOVIMIENTO_INVENTARIO(pk_id_movimiento_inventario);
alter table MOVIMIENTO_INVENTARIO_DETALLE add constraint fk_mov_inventario_detalle_producto foreign key(fk_id_producto) references PRODUCTO(pk_id_producto);

###MRP---------------------------------------------------------------------------------------------
create table if not exists TIPO_INVENTARIO (
  pk_id_tipo_inventario 					int(10) not null primary key auto_increment,
  nombre_tipo_inventario 					varchar(45) null,
  descripcion_tipo_inventario 				varchar(45) null
  ); 
create table if not exists MATERIA_PRIMA_INSUMO (
  pk_id_materia_prima_insumo 				int(10) not null primary key auto_increment,
  nombre_materia_prima_insumo				varchar(45) null,
  descripcion_materia_prima_insumo 			varchar(45) null,
  marca_materia_prima_insumo 				varchar(45) null,
  estado_materia_prima_insumo 				tinyint(1) null,
  precio_materia_prima_insumo 				double null
);
create table if not exists INVENTARIOMRP(
  pk_id_inventario 							int(10) not null primary key auto_increment,
  fk_id_materia_prima_insumo_inventario		int(10) null,
  fk_id_tipo_inventario_inventario 			int(10) null,
  fecha_inventario							date null,
  cantidad_inventario						int(10) null,
  estado_inventario							int(2)
);
alter table INVENTARIOMRP add constraint fk_INVENTARIO_MATERIA_PRIMA_INSUMO foreign key (fk_id_materia_prima_insumo_inventario) references MATERIA_PRIMA_INSUMO (pk_id_materia_prima_insumo) on delete no action on update no action;
alter table INVENTARIOMRP add constraint fk_INVENTARIO_TIPO_INVENTARIO foreign key (fk_id_tipo_inventario_inventario) references TIPO_INVENTARIO(pk_id_tipo_inventario) on delete no action on update no action;

create table if not exists ORDEN_PRODUCCION (
  pk_id_orden_produccion 					int(10) not null primary key auto_increment,
  fk_id_tipo_producto_orden_produccion 		int(10) null,
  cantidad_orden_produccion					int(10) null,
  fecha_orden_produccion 					varchar(45) null,
  estado_orden_produccion 					tinyint(1) null
);
alter table ORDEN_PRODUCCION add constraint fk_ORDEN_PRODUCCION_TIPOINVENTARIO foreign key (fk_id_tipo_producto_orden_produccion) references TIPO_INVENTARIO (pk_id_tipo_inventario) on delete no action on update no action;

create table if not exists CONTROL_CALIDAD(#Falta una relacion
  pk_id_control_calidad						int(10) not null primary key auto_increment,
  fk_id_orden_produccion_control_calidad 	int not null,
  fk_id_inventario_control_calidad 			int not null, #porque inventario?
  fk_id_responsable_control_calidad 		int(10) not null,
  resultado_control_calidad					varchar(45),
  estado_control_calidad					int(2)
);
alter table CONTROL_CALIDAD add constraint fk_CONTROL_CALIDAD_ORDEN_PRODUCCION1 foreign key (fk_id_orden_produccion_control_calidad) references ORDEN_PRODUCCION (pk_id_orden_produccion)on delete no action on update no action;
alter table CONTROL_CALIDAD add constraint fk_CONTROL_CALIDAD_INVENTARIO1 foreign key (fk_id_inventario_control_calidad) references INVENTARIOMRP (pk_id_inventario) on delete no action on update no action;

create table if not exists ESTADO_PRODUCCION(
  pk_id_estado_produccion 					int(10) not null primary key auto_increment,
  nombre_estado_produccion 					varchar(45) null,
  duracion_estado_produccion				varchar(45) null
);
create table if not exists CONTROL_PRODUCTO (
  pk_id_control_producto 					int(10) not null primary key auto_increment,
  fk_id_orden_produccion_control_producto 	int(10) null,
  fk_id_estado_produccion_control_producto	int(10) null,
  resultado_control_producto				varchar(45),
  estado_control_producto					int(2)
);
alter table CONTROL_PRODUCTO add constraint fk_CONTROL_PRODUCTO_ORDEN_PRODUCCION1 foreign key (fk_id_orden_produccion_control_producto) references ORDEN_PRODUCCION (pk_id_orden_produccion)on delete no action on update no action;
alter table CONTROL_PRODUCTO add constraint fk_CONTROL_PRODUCTO_ESTADO_PRODUCCION foreign key (fk_id_estado_produccion_control_producto) references ESTADO_PRODUCCION (pk_id_estado_produccion) on delete no action on update no action;

create table if not exists HORA_EMPLEADO (#Falta relacion con empleado
  pk_id_hora_empleado						int(10) not null primary key auto_increment,
  fk_id_empleado_hora_empleado				int(10) null,
  tiempo_hora_empleado						double null,
  fk_id_orden_produccion_hora_empleado		int null#porque se necesita orden de produccion?
);
alter table HORA_EMPLEADO add constraint fk_HORA_EMPLEADO_ORDEN_PRODUCCION1 foreign key (fk_id_orden_produccion_hora_empleado) references ORDEN_PRODUCCION (pk_id_orden_produccion) on delete no action on update no action;

create table if not exists ORDEN_COMPRA(
  pk_id_orden_compra 						int(10) not null primary key auto_increment,
  fk_id_materia_prima_insumo_orden_compra 	int null,
  fecha_envio_orden_compra			 		date null,
  cantidad_orden_compra 		 			int null,
  estado_orden_compra						tinyint(1) null
);
alter table ORDEN_COMPRA add constraint fk_ORDEN_COMPRA_MATERIA_PRIMA_INSUMO foreign key (fk_id_materia_prima_insumo_orden_compra) references MATERIA_PRIMA_INSUMO (pk_id_materia_prima_insumo) on delete no action on update no action;

create table if not exists TIPO_PRODUCTO_ENCABEZADO (
  pk_id_tipo_producto_encabezado	 		int(10) not null primary key auto_increment,
  nombre_tipo_producto_encabezado			varchar(45) null,
  descripcion_tipo_producto_encabezado 		varchar(45) null,
  precio_tipo_producto_encabezado 			double null,
  estado_tipo_producto_encabezado			int(2)
  );
create table if not exists PRODUCTO_DETALLE (
  pk_id_producto_detalle 							int(10) not null primary key auto_increment,
  fk_id_tipo_producto_encabezado_producto_detalle 	int null,
  fk_id_materia_prima_insumo_producto_detalle 		int null,
  cantidad_producto_detalle 						int null,
  estado_producto_detalle							int(2)
);
alter table PRODUCTO_DETALLE add constraint fk_PRODUCTO_DETALLE_TIPO_PRODUCTO_ENCABEZADO foreign key (fk_id_tipo_producto_encabezado_producto_detalle) references TIPO_PRODUCTO_ENCABEZADO(pk_id_tipo_producto_encabezado) on delete no action on update no action;
alter table PRODUCTO_DETALLE add constraint fk_PRODUCTO_DETALLE_MATERIA_PRIMA_INSUMO foreign key (fk_id_materia_prima_insumo_producto_detalle) references MATERIA_PRIMA_INSUMO(pk_id_materia_prima_insumo) on delete no action on update no action;

###CRM---------------------------------------------------------------------------------------------
create table if not exists CLIENTE (
  pk_id_cliente 					int not null auto_increment,
  nombre_cliente 					varchar(45) null,
  apellido_cliente 					varchar(45) null,
  fecha_de_nacimiento_cliente 		date null,
  primary key(pk_id_cliente)
);
create table if not exists CATEGORIA_TAMAÑO (
  pk_id_categoria_tamaño 			int not null,
  nombre_categoria_tamaño 			varchar(45) null,
  descripcion_categoria_tamaño 		varchar(45) null,
  primary key (pk_id_categoria_tamaño)
);
create table if not exists CATEGORIA_TIPO (
  pk_id_categoria_tipo 				int not null auto_increment,
  nombre_categoria_tipo 			varchar(45) null,
  descripcion_categoria_tipo 		varchar(45) null,
  primary key (pk_id_categoria_tipo)
);
create table if not exists PRODUCTOCRM (
  pk_id_producto 					int not null auto_increment,
  nombre_producto 					varchar(45) null,
  precio_producto 					varchar(45) null,
  descripcion_producto 				varchar(45) null,
  fk_id_categoria_tamaño_producto 	int not null,
  fk_id_categoria_tipo_producto 	int not null,
  primary key (pk_id_producto)
);
alter table PRODUCTOCRM add constraint fk_tbl_producto_tbl_categoriatamaño1 foreign key (fk_id_categoria_tamaño_producto)references CATEGORIA_TAMAÑO (pk_id_categoria_tamaño)on delete no action on update no action;
alter table PRODUCTOCRM add constraint fk_tbl_producto_tbl_categoriatipo1 foreign key (fk_id_categoria_tipo_producto)references CATEGORIA_TIPO (pk_id_categoria_tipo) on delete no action on update no action;

create table if not exists VENTA (
  pk_idventa 						int not null auto_increment,
  fecha_venta 						date null,
  fk_id_cliente_venta 				int not null,
  fk_id_producto_venta 				int not null,
  Descuento 						varchar(45) null,
  primary key (pk_idventa)
);
alter table VENTA add constraint fk_tbl_venta_tbl_cliente foreign key (fk_id_cliente_venta)references CLIENTE (pk_id_cliente)on delete no action on update no action;
alter table VENTA add constraint fk_tbl_venta_tbl_producto1 foreign key (fk_id_producto_venta)references PRODUCTO (pk_id_producto)on delete no action on update no action;

create table if not exists FACTURA (
  pk_id_factura 					int not null auto_increment,
  fk_id_cliente_factura 			int not null,
  fK_id_empleado_factura 			int not null,
  fecha_factura 					date null,
  primary key (pk_id_factura)
);
alter table FACTURA add constraint fk_tbl_factura_tbl_cliente1 foreign key (fk_id_cliente_factura)references CLIENTE (pk_id_cliente)on delete no action on update no action;

create table if not exists CUENTAS_POR_COBRAR (
  pk_id_cuenta_po_cobrar 			int not null auto_increment,
  cuota_cuentas_por_cobrar 			varchar(45) not null,
  abono_cuentas_por_cobrar 			varchar(45) null,
  fk_id_factura_cuentas_por_cobrar 	int not null,
  fk_id_cliente_cuentas_por_cobrar 	int not null,
  primary key (pk_id_cuenta_po_cobrar)
);
alter table CUENTAS_POR_COBRAR add constraint fk_tbl_cuentasporcobrar_tbl_factura1 foreign key (fk_id_factura_cuentas_por_cobrar)references FACTURA (pk_id_factura)on delete no action on update no action;
alter table CUENTAS_POR_COBRAR add constraint fk_tbl_cuentasporcobrar_tbl_cliente1 foreign key (fk_id_cliente_cuentas_por_cobrar)references CLIENTE (pk_id_cliente)on delete no action on update no action;

create table if not exists INVENTARIOCRM (
  pk_id_inventario 					int not null auto_increment,
  existencia_inventario 			int null,
  fk_idproducto_inventario 			int not null,
  primary key (pk_id_inventario)
);
alter table INVENTARIOCRM add constraint fk_tbl_inventario_tbl_producto1 foreign key (fk_idproducto_inventario)references PRODUCTO (pk_id_producto)on delete no action on update no action;

create table if not exists CORREO_CLIENTE (
  pk_id_correo_cliente 				int not null auto_increment,
  correo_correo_cliente 			varchar(45) null,
  fk_id_cliente_correo_cliente 		int not null,
  primary key (pk_id_correo_cliente)
);
alter table CORREO_CLIENTE add constraint fk_tbl_correo_tbl_cliente1 foreign key (fk_id_cliente_correo_cliente)references CLIENTE (pk_id_cliente)on delete no action on update no action;

create table if not exists TELEFONO_CLIENTE (
  pk_idtelefono 					int not null auto_increment,
  Telefono_telefono_cliente 		varchar(8) null,
  fk_id_cliente_telefono_cliente 	int not null,
  PRIMARY KEY (pk_idtelefono)
);
alter table TELEFONO_CLIENTE add constraint fk_tbl_telefono_tbl_cliente1 foreign key (fk_id_cliente_telefono_cliente)references CLIENTE (pk_id_cliente)on delete no action on update no action;

create table if not exists DIRECCION_CLIENTE (
  pk_id_direccion_cliente 			int not null auto_increment,
  numero_direccion_cliente 			varchar(45) null,
  calle_direccion_cliente 			varchar(45) null,
  colonia_direccion_cliente 		varchar(45) null,
  ciudad_direccion_cliente 			varchar(45) null,
  fk_idcliente_direccion_cliente 	int not null,
  primary key (pk_id_direccion_cliente)
);
alter table DIRECCION_CLIENTE add constraint fk_tbl_direccionCliente_tbl_cliente1 foreign key (fk_idcliente_direccion_cliente)references CLIENTE (pk_id_cliente)on delete no action on update no action;

create table if not exists CONTROL_EMPLEADO (
  pk_idControlEmpleado 							int not null auto_increment,
  Horas_Efectivas_De_Trabajo_controlempleado 	varchar(45) null,
  Horas_Extras_controlempleado 					varchar(45) null,
  Comisiones_controlempleado 					varchar(45) null,
  fK_id_empleado_controlempleado 				int not null,
  fk_id_venta_control_empleado 					int not null,
  primary key (pk_idControlEmpleado)
);
alter table CONTROL_EMPLEADO add constraint fk_TBL_CONTROL_EMPLEADO_TBL_VENTA1 foreign key (fk_id_venta_control_empleado)references VENTA (pk_idventa)on delete no action on update no action;
 
create table if not exists DETALLE_FACTURA (
  pk_id_detalle_factura 			int not null auto_increment,
  fk_id_factura_detalle_factura 	int not null,
  fk_id_producto_detalle_factura 	int not null,
  cantidad_detalle_factura 			int null,
  precio_detalle_factura 			float null,
  descuento 						varchar(45) null,
  primary key (pk_id_detalle_factura)
);
alter table DETALLE_FACTURA add constraint fk_TBL_DETALLE_FACTURA_TBL_FACTURA1 foreign key (fk_id_factura_detalle_factura)references FACTURA (pk_id_factura)on delete no action on update no action;
alter table DETALLE_FACTURA add constraint fk_TBL_DETALLE_FACTURA_TBL_PRODUCTO1 foreign key (fk_id_producto_detalle_factura)references PRODUCTO (pk_id_producto)on delete no action on update no action;

create table if not exists PEDIDOS (
  pk_id_pedido 						int not null auto_increment,
  nombre_pedido 					varchar(45) null,
  fecha_pedido						varchar(45) null,
  fk_id_empleado 					int not null,
  primary key (pk_id_pedido)
);

 CREATE TABLE IF NOT EXISTS DETALLE_PEDIDO(
  pk_id_detalle_pedido INT NOT NULL AUTO_INCREMENT,
  cantidad_producto VARCHAR(45) NULL,
  fk_id_producto INT NOT NULL,
  fk_id_pedido INT NOT NULL,
  PRIMARY KEY (pk_id_detalle_pedido)
);
alter table DETALLE_PEDIDO add constraint fk_DETALE_PEDIDO_PRODUCTO1 foreign key (fk_id_producto) references PRODUCTO (pk_id_producto)on delete no action on update no action;
alter table DETALLE_PEDIDO add constraint fk_DETALLE_PEDIDO_PEDIDOS1 foreign key (fk_id_pedido)references PEDIDOS (pk_id_pedido)on delete no action on update no action;

CREATE TABLE IF NOT EXISTS PRODUCTO_HAS_PEDIDOS (
  PRODUCTO_pk_idproducto INT NOT NULL,
  PEDIDOS_pk_id_pedido INT NOT NULL,
  PRIMARY KEY (PRODUCTO_pk_idproducto, PEDIDOS_pk_id_pedido)
);
alter table PRODUCTO_HAS_PEDIDOS add constraint fk_PRODUCTO_has_PEDIDOS_PRODUCTO1 foreign key (PRODUCTO_pk_idproducto)references PRODUCTO (pk_id_producto)on delete no action on update no action;
alter table PRODUCTO_HAS_PEDIDOS add constraint fk_PRODUCTO_has_PEDIDOS_PEDIDOS1 foreign key (PEDIDOS_pk_id_pedido)references PEDIDOS (pk_id_pedido)on delete no action on update no action;
 

#####RELACIONES-ENTRE-MODULOS----------------------------------------------------------------------
####RELACIONES-HRM---------------------------------------------------------------------------------
####RELACIONES-FRM---------------------------------------------------------------------------------
####RELACIONES-SCM---------------------------------------------------------------------------------
alter table ENCARGADO_BODEGA add constraint fk_empleado_encargado foreign key(fk_id_empleado) references EMPLEADO (pk_id_empleado);

####RELACIONES-MRP---------------------------------------------------------------------------------
alter table CONTROL_CALIDAD add constraint fk_EMPLEADOS_CONTROLCALIDAD1 foreign key (fk_id_responsable_control_calidad) references EMPLEADO (pk_id_empleado)on delete no action on update no action; 
alter table HORA_EMPLEADO add constraint fk_HORAEMPLEADO_EMPLEADO foreign key (fk_id_empleado_hora_empleado)references EMPLEADO (pk_id_empleado) on delete no action on update no action;
 
####RELACIONES-CRM---------------------------------------------------------------------------------
alter table FACTURA add constraint fk_TBL_FACTURA_EMPLEADO1 foreign key (fK_id_empleado_factura)references EMPLEADO (pk_id_empleado)on delete no action on update no action;
alter table CONTROL_EMPLEADO add constraint fk_TBL_CONTROL_EMPLEADO_EMPLEADO1 foreign key (fK_id_empleado_controlempleado)references EMPLEADO (pk_id_empleado)on delete no action on update no action;
alter table PEDIDOS add constraint fk_PEDIDOS_EMPLEADO1 foreign key (fk_id_empleado)references EMPLEADO (pk_id_empleado)on delete no action on update no action;
 
######ALTER-TABLES-RELACIONALES--------------------------------------------------------------------
