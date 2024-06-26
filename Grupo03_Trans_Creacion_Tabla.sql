------Creacion de tablas

CREATE TABLE grupo03.Maquinista(
	Id_Maquinista int not null primary key,
	Nombre_Maquinista varchar(250),
	Apellido_Maquinista varchar(250)
);

CREATE TABLE grupo03.Maquina(
	Id_Maquina int not null primary key,
	Maquina	varchar(250),
	Velocidad int,
	Cant_Cortes int,
	Id_Maquinista int,
	constraint fk_Maquinista foreign key (Id_Maquinista) references grupo03.Maquinista(Id_Maquinista)
);

CREATE TABLE grupo03.Tecnico(
	Id_Tecnico int not null primary key,
	Nombre varchar(250),
	Apellido varchar(250),
	Contraseña varchar(250),
	Cargo varchar(250)
);

CREATE TABLE grupo03.Turno(
	Id_Turno int not null primary key,
	Turno varchar(250)
);

CREATE TABLE grupo03.Repuestos(
	Id_Repuesto int not null primary key,
	Nombre varchar(250),
	Precio decimal(10,2),
	CONSTRAINT CHK_Precio_Negativo CHECK (Precio >= 0) 
);

CREATE TABLE grupo03.Seccion(
	Id_Seccion int not null primary key,
	Seccion varchar(250)
);

CREATE TABLE grupo03.Categoria(
	Id_Categoria int not null primary key,
	Categoria varchar(250),
	Id_Seccion int,
	constraint fk_Seccion foreign key (Id_Seccion) references grupo03.Seccion(Id_Seccion)
);

CREATE TABLE grupo03.Estado(
	Id_Estado int not null primary key,
	Estado varchar(250)
);

CREATE TABLE grupo03.Incidencia(
	Id_Incidencia int identity(1,1) not null primary key,
	Fecha_Hora_Registro datetime,
	Id_Maquina int,
	Fecha_Hora_Inicial_Parada datetime,
	Fecha_Hora_Final_Parada datetime,
	Id_Tecnico int,
	Id_Estado int,
	constraint fk_Maquina foreign key (Id_Maquina) references grupo03.Maquina(Id_Maquina),
	constraint fk_Tecnico foreign key (Id_Tecnico) references grupo03.Tecnico(Id_Tecnico),
	constraint fk_Estado foreign key (Id_Estado) references grupo03.Estado(Id_Estado)
);

CREATE TABLE grupo03.Reg_Mantenimiento(
	Id_Reg_Mantenimiento int identity(1,1) not null primary key,
	Fecha_Hora_Inicial_Reparacion datetime,
	Fecha_Hora_Final_Reparacion datetime,
	Id_Incidencia int,
	Id_Turno int,
	constraint fk_Incidencia foreign key (Id_Incidencia) references grupo03.Incidencia(Id_Incidencia),
	constraint fk_Turno foreign key (Id_Turno) references grupo03.Turno(Id_Turno)
);

CREATE TABLE grupo03.Detalle_Reg_Mantenimiento(
	Id_Detalle_Reg_Mantenimiento int identity(1,1) not null primary key,
	Id_Categoria int,
	Descripcion varchar(500),
	Id_Repuesto int,
	Id_Reg_Mantenimiento int,
	constraint fk_Categoria foreign key (Id_Categoria) references grupo03.Categoria(Id_Categoria),
	constraint fk_Repuestos foreign key (Id_Repuesto) references grupo03.Repuestos(Id_Repuesto),
	constraint fk_Reg_Mantenimiento foreign key (Id_Reg_Mantenimiento) references grupo03.Reg_Mantenimiento(Id_Reg_Mantenimiento)
);
