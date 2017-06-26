################################################################################
#                                                                              #
#                            Exercício 7 extra                                 #
#                      Por: Pedro Pereira, 9778794                             #
#                                                                              #
################################################################################

# Deixa o formato dos numeros ate 15 casas decimais
format long;

# Aplica as regras de integrais para aproximar a integral das funcoes.
# f = funcao a ser avaliada e aproximada
# a = comeco do intervalo em |R
# b = final do intervalo em |R
# n = numero de intervalos uniformes
function [midpoint, trapezoid, simpson] = applyIntegralAprox(f, a, b, n)
    # Calcula os n pontos
    X = linspace(a, b, n + 1);
    # Calcula o h
    h = X(2) - X(1);
    midpoint = midPointRule(f, X, h);
    trapezoid = trapezoidRule(f, X, h);
    simpson = simpsonRule(f, X, h);
end

# Imprime a funcao, as aproximacoes de cada metodo e o erro delas
# integral_function e a mesma da analyzeError().
function printIntegralAprox(f, integral_function, a, b, n)
    [midpoint, trapezoid, simpson] = applyIntegralAprox(f, a, b, n);
    disp(["funcao: "   func2str(f);
          "numero de intervalos: " num2str(n);
          "\tmidpoint = " num2str(midpoint);
          "\ttrapezoid = " num2str(trapezoid);
          "\tsimpson = " num2str(simpson)]);

    e_midpoint = analyzeError(integral_function, a, b, midpoint);
    e_trapezoid = analyzeError(integral_function, a, b, trapezoid);
    e_simpson = analyzeError(integral_function, a, b, simpson);
    real_integral = integral_function(b) - integral_function(a);
    disp(["Integral analitica = " num2str(real_integral)]);
    disp(["Erros absolutos:" "";
         "\tmidpoint = " num2str(e_midpoint);
         "\ttrapezoid = " num2str(e_trapezoid);
         "\tsimpson = " num2str(e_simpson)]);
    disp("\n\n")
end

# Analisa a diferenca entre a integral e a integral aproximada
# integral_function e uma funcao anonima @(x).
function abs_error = analyzeError(integral_function, a, b, aproxIntegral)
    # Calucla a integral verdadeira no intervalo.
    integ = integral_function(b) - integral_function(a);
    # Retorna o erro
    abs_error = abs(integ - aproxIntegral);
end

# Regra do ponto medio
function integ = midPointRule(f, X, h)
    # Cria copia do vetor original até um antes e soma metade do intervalo
    # uniforme a cada (Essencialmente pegando o ponto medio de cada um)
    M = (X + (h/2))(1:end-1);
    soma = 0;
    # Faz a soma de todas as pequenas integrais
    for i = M
        # Retangulo f(i) * h
        soma += f(i) * h;
    end
    # Retorna a integral
    integ = soma;
end

# Regra do trapezio
# Erro calculado: -f''(zeta)/12 * (b - a) * h^2
function integ = trapezoidRule(f, X, h)
    # Soma de integrais
    soma = 0;
    for i = X(2:end-1)
        soma += 2 * f(i);
    end
    # Soma as pontas com peso 1
    soma += f(X(1));
    soma += f(X(end));

    # multiplica pelas areas dos retangulos
    soma *= h / 2;

    # Retorna a integral
    integ = soma;
end

# Regra de simpson
function integ = simpsonRule(f, X, h)
    soma = 0;
    # Temos que considerar que há 2n+1 pontos, 2n intervalos
    # Se não houver 2n intervalos, remove um ponto para que haja
    if(mod(length(X), 2) != 1)
        disp("ATENCAO: Regra de simspon: Ha numero par de pontos (numero impar de intervalos)");
        disp("O programa continuara, mas removendo um ponto da malha.");
        M = X(1:end-1);
    else
        # Cria uma deep copy
        M = X + 0;
    end

    l = length(M);
    # Faz os pontos do meio. (sem as bordas 1 e l)
    for i = 2:l-1
        # Octave comeca indices a partir do 1: entao se tiver indice par, multiplica por 4
        # Caso contrario multiplica por 2
        if(mod(i, 2) == 0)
            soma += 4 * f(M(i));
        else
            soma += 2 * f(M(i));
        end
    end
    # Lida com os pontos da borda: peso 1
    soma += f(M(1));
    soma += f(M(end));

    # Multiplica pelo tamanho das caixinhas: h / 3
    soma *= h / 3;

    # Retorna a integral
    integ = soma;
end

# Resolve a parte a) e b) do exercicio.
function demo()

    # parte a) 4 / (1 + x^2)
    # integral = 4 arctg(x)
    # 2 subintervalos
    printIntegralAprox(@(x) 4 / (1 + x^2),
                       @(x) 4 * atan(x),
                       0, 1, 2);
    # 4 subintervalos
    printIntegralAprox(@(x) 4 / (1 + x^2),
                       @(x) 4 * atan(x),
                       0, 1, 4);
    # 8 subintervalos
    printIntegralAprox(@(x) 4 / (1 + x^2),
                       @(x) 4 * atan(x),
                       0, 1, 8);

    # 16 subintervalos
    printIntegralAprox(@(x) 4 / (1 + x^2),
                       @(x) 4 * atan(x),
                       0, 1, 16);
    # 32 subintervalos
    printIntegralAprox(@(x) 4 / (1 + x^2),
                       @(x) 4 * atan(x),
                       0, 1, 32);
    # 64 subintervalos
    printIntegralAprox(@(x) 4 / (1 + x^2),
                       @(x) 4 * atan(x),
                       0, 1, 64);


    # parte b) sqrt(x)
    # integral = 2 * x^(3/2) / 3
    # 2 subintervalos
    printIntegralAprox(@(x) sqrt(x),
                       @(x) 2 * x.^(3/2) / 3,
                       0, 1, 2);
    # 4 subintervalos
    printIntegralAprox(@(x) sqrt(x),
                       @(x) 2 * x.^(3/2) / 3,
                       0, 1, 4);
    # 8 subintervalos
    printIntegralAprox(@(x) sqrt(x),
                      @(x) 2 * x.^(3/2) / 3,
                      0, 1, 8);
    # 16 subintervalos
    printIntegralAprox(@(x) sqrt(x),
                     @(x) 2 * x.^(3/2) / 3,
                     0, 1, 16);
    # 32 subintervalos
    printIntegralAprox(@(x) sqrt(x),
                      @(x) 2 * x.^(3/2) / 3,
                      0, 1, 32);
    # 64 subintervalos
    printIntegralAprox(@(x) sqrt(x),
                      @(x) 2 * x.^(3/2) / 3,
                      0, 1, 64);
end
