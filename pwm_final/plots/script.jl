using Plots
using ColorSchemes

##

const fsys = 5e7

fpwm(fdiv, M) = fsys / (fdiv * (M + 1))
M(fdiv, fpwm) = ((fsys / fdiv) - fpwm) / fpwm
approx_fpwm(fdiv, f) = fpwm(fdiv, round(M(fdiv, f)))

fdivs = [1, 2, 4, 8, 16, 32, 64, 128]
p1 = Plots.scatter(xlims=[1, 1e6], ylims=[0, 0.55], xlabel="Frequência desejada", ylabel="Erro relativo (%)", title="Erros por divisão de frequência", legendtitle="Divisões", legend=:topleft, palette=:RdYlBu_8, xaxis=:log10, dpi=1000, color=:green, background_color=:lightgray, xticks=[10^n for n in 0:7])
for fdiv in fdivs
    vline!(p1, [fpwm(fdiv, 99)], linestyle=:dash, label="")
end
for fdiv in fdivs
    global p1
    X = Vector{Float64}()
    Y = Vector{Float64}()
    ymax = 0
    fmin = fdiv == 128 ? 0 : fpwm(fdiv * 2, 99)
    fmax = fpwm(fdiv, 99)
    for f in fmin:100:fmax
        v = abs(f - approx_fpwm(fdiv, f)) / abs(f)
        #println("$f: $v")
        if v > ymax
            if isinf(v)
                continue
            end
            ymax = v
            push!(X, f)
            push!(Y, 100 * v)
        end
    end
    Plots.scatter!(p1, X, Y, label="$fdiv")
end

Plots.savefig(p1, "err_rel_div_freq.svg")

##

for fdiv in fdivs
    p2 = Plots.plot(xlims=[1, 1e7], xlabel="Frequência desejada", ylabel="Valor", title="Valores de max (div = $fdiv)", legend=:topleft, xaxis=:log10, yaxis=:log10, dpi=1000, background_color=:lightgray, xticks=[10^n for n in 0:7])
    X = Vector{Float64}()
    Y = Vector{Float64}()
    mmin = M(fdiv, 1)
    for f in 1:100:1e7
        v = M(fdiv, f)
        if v < 0
            break
        end
        if v < mmin
            mmin = v
            push!(X, f)
            push!(Y, round(v, sigdigits=2))
        end
    end
    Plots.plot!(p2, X, Y, label="")
    Plots.plot!(p2, a -> 99, label="")
    Plots.savefig(p2, "max_per_freq_$fdiv.svg")
end