################################################################################
#                                                                              #
#                            Exercício 7 extra                                 #
#                      Por: Pedro Pereira, 9778794                             #
#                                                                              #
################################################################################

1;

# Aplica as regras de integrais para aproximar a integral das funcoes.
# f = funcao a ser avaliada e aproximada
# a = comeco do intervalo em |R
# b = final do intervalo em |R
# n = numero de intervalos uniformes
function applyIntegralAprox(f, a, b, n)
    # Calcula os n pontos
    X = linspace(a, b, n);
    # Calcula o h
    h = X(2) - X(1);

end

# Regra do ponto medio
function [integral] = midPointRule(f, X, h)

end

# Regra do trapezio
# Erro calculado: -f''(zeta)/12 * (b - a) * h^2
function integral = trapezoidRule(f, X, h)
    # Soma de integrais
    l = length(X);
    soma = 0;
    for i = 2:l-1:1
        soma += 2 * f(X(i));
    end
    # Soma as pontas com peso 1
    soma += f(X(1));
    soma += f(X(l));

    # multiplica pelas areas dos retangulos
    soma *= h / 2;

    # Retorna a integral
    integral = soma;
end

# Regra de simpson
function [integral] = simpsonRule(f, X, h)
    
end

# Resolve a parte a) e b) do exercicio.
function demo()


end
