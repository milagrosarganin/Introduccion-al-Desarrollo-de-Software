# #!/bin/bash
# echo "---------------------------------------------" 
# echo "---------------parte 1-----------------------" 
# echo "---------------------------------------------" 
# #1
# nombre="Milagros"
# echo "Hola, $nombre"

# echo "---------------------------------------------"  #2

# numero_1=2
# numero_2=3
# suma=$(($numero_1+$numero_2))
# echo "La suma de $numero_1 y $numero_2 es igual a: $suma"

# echo "---------------------------------------------"  #3

# read -p "ingrese su nombre y apellido: " NOMBRE APELLIDO
# echo "Su nombre completo es: $NOMBRE $APELLIDO"

# echo "---------------------------------------------"  #4

# read -p "Ingresa tu nombre: " NOMBRE
# read -p "Ingresa tu apellido: " APELLIDO
# #muestro nombre y apellido
# echo "Su nombre completo es $APELLIDO $NOMBRE"

# echo "---------------------------------------------" #5

# echo "Vamos a calcular el perímetro de un rectángulo"
# read -p "Ingrese la altura: " ALTURA
# read -p "Ingrese la base: " BASE
# #calculo el perímetro del rectángulo
# perimetro=$(($ALTURA*$BASE))
# #muestro el resultado
# echo "El perímetro es de: $perimetro"

# echo "---------------------------------------------" 
# echo "----------------parte 2----------------------"
# echo "---------------------------------------------" 

# #1
# read -p "ingrese un número: " numero
# if [ $numero -gt 0 ]; 
#     then echo "el $numero es mayor que 0"

# elif [ $numero -lt 0 ]; 
#     then echo "el $numero es menor que 0"

# else
#     echo "el $numero es igual que 0"
# fi

# echo "---------------------------------------------" #2

# read -p "Ingrese su edad: " edad

# if [ $edad -ge 18 ];
#     then echo "Usted es mayor de edad"
# else 
#     echo "Usted es menor de edad"
# fi

# echo "---------------------------------------------" #3

# read -p "Ingrese un numero: " numero
# #hago el resto
# Resto=$(($numero%2))
# if [ $Resto -eq 0 ];
#     then echo "El $numero es par"
# else
#     echo "el $numero es impar"
# fi

# echo "---------------------------------------------" #4

# read -p "ingrese su nombre: " nombre

# if [ $nombre == "Manu" ];
#     then echo "Hola profe :)"
# else 
#     echo "Hola $nombre :)"
# fi

# echo "---------------------------------------------" #5

# read -p "ingrese la longitud de un lado: " lado_1
# read -p "ingrese la longitud de otro lado: " lado_2
# read -p "ingrese la longitud del último lado: " lado_3

# #hago el condicional

# if [[ $lado_1 -eq $lado_2 && $lado_1 -eq $lado_3 ]];
#     then echo "El triangulo es equilatero"
# elif [[
#     $lado_1 -eq $lado_2 ||
#     $lado_1 -eq $lado_3 ||
#     $lado_3 -eq $lado_2
#     ]];
#     then echo "El triangulo es isosceles"
# else
#     echo "el triangulo es escaleno"
# fi

# echo "---------------------------------------------" #6

# suma(){
#     read -p "Ingrese un numero: " n_1
#     read -p "Ingrese otro numero: " n_2
#     echo $(($n_1+$n_2))
# }

# resta(){
#     read -p "Ingrese un numero: " n_1
#     read -p "Ingrese otro numero: " n_2
#     echo $(($n_1-$n_2))
# }

# multiplicacion(){
#     read -p "Ingrese un numero: " n_1
#     read -p "Ingrese otro numero: " n_2
#     echo $(($n_1*$n_2))
# }

# division(){
#     read -p "Ingrese un numero: " n_1
#     read -p "Ingrese el nuemro por el cual queire dividir el nuemro anterior: " n_2
#     if [ $n_2 -le 0 ];
#         then echo "Recuerde que no se puede dividir por 0, ingrese un numero mayor a cero cuando se le pida el divisor"
#     else
#         echo $(($n_1/$n_2))
#     fi
# }

# #Uso de las funciones

# echo "Funcion suma"
# suma

# echo "Funcion resta"
# resta

# echo "Funcion multiplicacion"
# multiplicacion

# echo "Funcion division"
# division

# echo "---------------------------------------------" 
# echo "-----------------parte 3---------------------"
# echo "---------------------------------------------" 

#1

primeros_n(){
    read -p "ingrese la cantidad de numero natuarles que quiera ver: " n
    for i in $(seq 1 $n); do
        echo $i
    done
}

echo "usamos la funcion primeros_n para ver los nueros naturales"
primeros_n

echo "---------------------------------------------" 

#2

factorial(){
    read -p "ingrese el numero del cual quiere daber su factorial: " n_fact
    base=1 #numero de base para poder multiplicar
    if [ $n_fact -le 0 ]; 
        then echo "Recuerde que no se puede realizar el factorial de un número menor o igual cero"
    else
        #bucle for
        for i in $(seq 1 $n_fact); do
            base=$(($base*$i))
        done
        echo "El resultado de $n_fact! es $base"
    fi
}

#usamos la funcion factorial
echo "funcion fcatorial"
factorial

echo "---------------------------------------------" 

#3

numero_par(){
    read -p "ingrese un numero: " numero

    while [ $(($numero%2)) -ne 0 ]; do
        echo "ingresaste un numero impar, proba de nuevo"
        read -p "ingrese un numero: " numero
    done

    echo "bien hecho ingresaste un numero par"
}

#uso de la funcion numero_par

echo "funcion nuemros pares"
numero_par

echo "---------------------------------------------" 

#4

dias_de_la_semana(){
    
    read -p "Ingrese el numero del dia de la semana que quiere saber: " dia

    dias=("A" "lunes" "Martes" "Miercoles" "Jueves" "Viernes" "Sabado" "Domingo")

    indice=0
    while [[ $dia -le 0 || $dia -gt 7 ]]; do
        echo "debe ingresar un numero entre 1 y 7, no mayor o menor, inetnta de nuevo"
        read -p "Ingrese el numero del dia de la semana que quiere saber: " dia
    done
    dia_sem=${dias[dia]}
    echo "el dia de la semana que le corresponde al el numero $dia es $dia_sem, teniendo en cuenta que la semana comienza el lunes"
}

#uso de la funcion
dias_de_la_semana

echo "---------------------------------------------" 

#5

impresion_n_nat(){
    read -p "Ingrese un numero natural: " num
    if [ $num -gt 0 ]; 
        echo "el numero ingresado es: $num"
        then bandera="True"
        while [ $bandera == "True" ]; do
            read -p "Queres seguir imprimendo? ingresa 'y' (yes) o 'n' (no): " rta
            if [ $rta == "n" ]; 
                then bandera="False"
            else 
                read -p "Ingrese un numero natural: " num
                if [ $num -gt 0 ]; 
                    then echo "el numero ingresado es: $num"
                else
                    echo "debe ingresar un numero mayor a cero"
                    read -p "Ingrese un numero natural: " num
                fi
            fi
        done
    else
        echo "debe ingresar un numero mayor a cero"
    fi
}

#uso la funcion
impresion_n_nat

echo "---------------------------------------------" 

#6

