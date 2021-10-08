program tpayed2;
uses crt, sysutils;

var
option:char;
access:boolean;
empresas: array[0..9,0..5] of string;
ciudades: array[0..9,0..2] of string;
clientes: array[0..9,0..1] of string;
proyectos: array[0..9,0..5] of string;
//productos = array[0..10,0] of string;

contEmpresas, contCiudades, contClientes, contProyectos{, contProductos}:integer; 

procedure ordenarCiudades();
	var
		i,k: Integer;
		aux: string;
	begin
		// for i := 0 to contCiudades do
		i := contCiudades;
		while (i >= 0) do
			begin
	      if ciudades[i - 1][0] > ciudades[i][0] then //SE FIJA SI ES MAYOR
	        for k := 0 to 2 do
	        	//COPIA LOS DATOS DE UNA A OTRA
	          begin
	            aux := ciudades[i][k];
	            ciudades[i][k] := ciudades[i - 1][k];
	            ciudades[i - 1][k] := aux;
	          end;
	      i:= i - 1;
      end;
	end;

procedure mostrarCiudades();
	var
		max, i, id: Integer;
	begin
		max := 0;
		id := 0;
		for i:= 0 to contCiudades do
		begin
		writeln(ciudades[i][1]+' - '+ciudades[i][2]);
		if (ciudades[i][2] <> '') then
			if (StrToInt(ciudades[i][2]) > max) then
			begin
				max := StrToInt(ciudades[i][2]);
				id := i;
			end;
		end;
		writeln('La ciudad con mas empresas es '+ciudades[id][1]+', con un total de '+ciudades[id][2]+' empresas registradas.');
	end;

procedure altaEmpresa();
	var
		opt: string;
		pass: boolean;
		i: integer;
	begin
		pass:=false;
		ClrScr();
		writeln('Ingrese el codigo de la empresa.'); //string(3)
		repeat //VALIDACION DE LARGO DEL CODIGO
			readln(empresas[contEmpresas][0]);
			empresas[contEmpresas][0] := AnsiUpperCase(empresas[contEmpresas][0]);
			if(length(empresas[contEmpresas][0])<=3) then
				pass:=true
			else
				writeln('El codigo debe tener un maximo de 3 caracteres. Ingreselo nuevamente:');
		until(pass=true);
		pass:=false;
		writeln('Ingrese el nombre de la empresa.');
		readln(empresas[contEmpresas][1]);
		writeln('Ingrese la direccion de la empresa.');
		readln(empresas[contEmpresas][2]);
		writeln('Ingrese el mail de la empresa.');
		readln(empresas[contEmpresas][3]);
		writeln('Ingrese el telefono de la empresa.');
		readln(empresas[contEmpresas][4]);
		writeLn('Selecciona una ciudad');
		for i := 0 to contCiudades-1 do
			writeLn(IntToStr(i+1) + '. ' + ciudades[i,1]); //ESCRIBE LAS OPCIONES
		repeat
			readln(opt); //LEE LA OPCION
		until (StrToInt(opt) <= contCiudades);
		ClrScr();
		for i := 0 to contCiudades-1 do
			begin
				if (opt = IntToStr(i)) then
					begin
						empresas[contEmpresas][5] := ciudades[i,0];
						ciudades[i][2] := IntToStr(StrToInt(ciudades[i][2]) + 1);
					end;
			end;
		writeln(Utf8ToAnsi('Empresa añadida exitosamente, pulse cualquier tecla para volver al menu anterior.'));
		readKey();
		contEmpresas := contEmpresas + 1;
	end;

procedure altaCliente();
	begin
		ClrScr();
		writeln('Ingrese el nombre del cliente.');
		readln(clientes[contClientes][0]);
		writeln('Ingrese el mail del cliente.');
		readln(clientes[contClientes][1]);
		writeln(Utf8ToAnsi('Cliente añadido exitosamente, pulse cualquier tecla para volver al menu anterior.'));
		readKey();
		contClientes := contClientes + 1;
	end;

procedure altaCiudad();
	begin
		ClrScr();
		writeln('Ingrese el codigo de la ciudad.');
		repeat
			readln(ciudades[contCiudades][0]);
			ciudades[contCiudades][0] := AnsiUpperCase(ciudades[contCiudades][0]);
		until length((ciudades[contCiudades][0] <=3));
		writeln('Ingrese el nombre de la ciudad.');
		readln(ciudades[contCiudades][1]);
		writeln(Utf8ToAnsi('Ciudad añadida exitosamente, pulse cualquier tecla para volver al menu anterior.'));
		ciudades[contCiudades][2] := '0';
		ordenarCiudades();
		mostrarCiudades();
		contCiudades := contCiudades+1;
		readKey();
	end;

procedure altaProyecto();
	var
		i: integer;
		pass:boolean;
		opt: string;
	begin
		ClrScr();
		writeln('Ingrese el codigo del proyecto.');
		repeat
			readln(proyectos[contProyectos][0]);
			proyectos[contProyectos][0] := AnsiUpperCase(proyectos[contProyectos][0]);
		until (length(proyectos[contProyectos][0] <= 3));
		proyectos[contProyectos][0] := AnsiUpperCase(proyectos[contProyectos][0]);
		writeLn('Selecciona una empresa');
		for i := 0 to contEmpresas-1 do
			writeLn(IntToStr(i+1) + '. ' + empresas[i,1]); //ESCRIBE LAS OPCIONES
		repeat
			readln(opt); //LEE LA OPCION
		until (StrToInt(opt) <= contEmpresas);
		ClrScr();
		for i := 0 to contEmpresas-1 do
			begin
				if (opt = IntToStr(i)) then
					begin
						proyectos[contProyectos][5] := empresas[i,0];
					end;
			end;
		writeln('Ingrese la etapa del proyecto.'+#13+#10+'P. Preventa'+#13+#10+'O. Obra'+#13+#10+'T. Terminado');
		repeat
			readln(proyectos[contProyectos][2]);
		until ((proyectos[contProyectos][2]= 'P') or (proyectos[contProyectos][2]= 'O') or (proyectos[contProyectos][2]= 'T'));
		writeln('Ingrese el tipo de proyecto.'+#13+#10+'C. Casa'+#13+#10+'D. Departamento'+#13+#10+'O. Oficina'+#13+#10+'L. Lotes');
		repeat
			readln(proyectos[contProyectos][3]);
		until ((proyectos[contProyectos][2]= 'C' ) or (proyectos[contProyectos][2]= 'D' ) or 
			(proyectos[contProyectos][2]= 'O' ) or (proyectos[contProyectos][2]= 'L' ));
		writeLn('Selecciona una ciudad');
		for i := 0 to contCiudades-1 do
			writeLn(IntToStr(i+1) + '. ' + ciudades[i,1]); //ESCRIBE LAS OPCIONES
		repeat
			readln(opt); //LEE LA OPCION
		until (StrToInt(opt) <= contCiudades);
		ClrScr();
		for i := 0 to contCiudades-1 do
			begin
				if (opt = IntToStr(i)) then
					begin
						proyectos[contProyectos][5] := ciudades[i,0];
					end;
			end;
		writeln(Utf8ToAnsi('Proyecto añadido exitosamente, pulse cualquier tecla para volver al menu anterior.'));
		contProyectos:=contProyectos+1;
		readKey();
	end;

procedure altaProducto();
	begin
		//Unused
	end;

procedure getProyecto(); //CAMBIAR!
var
	i, j: integer;
	opt: char;
begin
	writeLn('¿Que tipo de proyecto quieres consultar?'+#13+#10+'C. Casa'+#13+#10+'D. Edificio departamentado'
		+#13+#10+'O. Edificio oficina'+#13+#10+'L. Loteos respectivamente');
	opt:= readKey();
	ClrScr();
	for i := 0 to contProyectos do
		begin
			if proyectos[i,3] = opt then
				begin
					writeln('Proyecto: '+proyectos[i][0]);
					for j := 0 to contEmpresas do
						if empresas[j,0] = proyectos[i,1] then 
							writeln('Empresa: '+empresas[i][1]);
					case proyectos[i,2] of
						'P': writeln('Etapa: Preventa');
						'O': writeln('Etapa: Obra');
						'T': writeln('Etapa: Terminado');
					end;
					case proyectos[i,3] of
						'C': writeln('TIpo: Casa');
						'D': writeln('TIpo: Departamento');
						'O': writeln('TIpo: Oficina');
						'L': writeln('TIpo: Lote');
					end;
					for j := 0 to contCiudades do
						if ciudades[j,0] = proyectos[i,4] then 
							begin
								writeln('Ciudad: '+ciudades[i,1]);
							end;
					writeln('Cantidad: '+proyectos[i][5]);
				end;	
		end;
	writeln('Toque cualquier tecla para continuar');
	readKey();
end;

procedure showEmpresa();
	var
		opt: char;
begin
	repeat
		ClrScr();
	    writeln('MENU EMPRESAS DESARROLLADORAS:'+#13+#10+'1. Alta de CIUDADES '+#13+#10+'2. Alta de EMPRESAS '+#13+#10+'3. Alta de PROYECTOS'+#13+#10+'4. Alta de Productos '+#13+#10+'0. Volver al menu principal');
	    repeat
	    	opt := readKey();
	    until((opt = '1') or (opt = '2') or (opt = '3') or (opt = '4') or (opt = '0'));
	    case opt of
	    	'1': altaCiudad();
	    	'2': altaEmpresa();
	    	'3': altaProyecto();
	    	'4': altaProducto();
	    end;
	until(opt = '0');
end;

procedure showCliente();
	var
		opt: char;
begin
	repeat
		ClrScr();
		writeln('MENU CLIENTES:'+#13+#10+'1. Alta de Clientes '+#13+#10+'2. Consulta de PROYECTOS'+#13+#10+'0. Volver al menu principal');
		repeat
      opt := readKey();
    until ((opt = '1') or (opt = '2') or (opt = '0'));
    case opt of
	    '1': altaCliente();
	    '2': getProyecto();
    end;
  until(opt = '0');
end;

function login(tipo: char): boolean;
var
  attempts: integer;
  clave, secret1, secret2 : string;
  c:char;
begin
  attempts := 3;
  clave := '';
  secret1 := 'admin123';
  secret2 := 'user123';
  while (attempts > 0) do
    begin
      attempts := (attempts-1);
      ClrScr();
      writeln('Ingrese la clave. ', attempts+1, ' intentos restantes');
      repeat
        c := readKey();
        ClrScr();
        writeln('Ingrese la clave. ', attempts+1, ' intentos restantes');
        if(c = #08) then
        	begin
	          delete(clave,length(clave),1);
	          for contEmpresas := 1 to length(clave) do
	            write('*');
        	end
        else
	        begin 
	        	if (c <> #13) then
	        	begin
		            clave := clave + c;
		            for contEmpresas := 1 to length(clave) do
		              write('*')
		        end;
	        end;
      until(c = #13);
      if (tipo = '1') then
      begin
        if (clave = secret1) then
          exit(true)
        else
       	  clave := '';
          writeln('Clave incorrecta');
      end;
      if (tipo = '2') then
      begin
        if (clave = secret2) then
          exit(true)
        else
          clave := '';
          writeln('Clave incorrecta');
      end;
    end;
  writeln('Agotaste los intentos, pulsa cualquier tecla para continuar.');
  readKey();
  Halt(0);
end;

BEGIN //Main
	contProyectos := 0;
	contCiudades := 3;
	contClientes := 0;
	contEmpresas := 0;
	proyectos[0][0] := 'Pr1';
	proyectos[0][1] := 'Co1';
	proyectos[0][2] := 'P';
	proyectos[0][3] := 'C';
	proyectos[0][4] := 'CBA';
	proyectos[0][5] := '2';
  ciudades[0][0] := 'BAS';
  ciudades[0][1] := 'Buenos Aires';
  ciudades[0][2] := '0';
  ciudades[1][0] := 'ROS';
  ciudades[1][1] := 'Rosario';
  ciudades[1][2] := '0';
  ciudades[2][0] := 'CBA';
  ciudades[2][1] := 'Cordoba';
  ciudades[2][2] := '0';
  repeat
  	ClrScr();
  	writeln('Menu: '+#13+#10+'1. Empresas.'+#13+#10+'2. Clientes.'+#13+#10+'0. Salir'+#13+#10+'');
	   //menu principal
		repeat
      option := readKey();
		until ((option = '1') or (option = '2') or (option = '0'));
		if (option <> '0') then
		begin
		  //login
		  access := login(option);
		  //mostrar submenu
	    if (access) then
	    begin
	       case option of
            '1': showEmpresa();
            '2': showCliente();
	       end;
	    end;
		end;
	until (option = '0');
END.
