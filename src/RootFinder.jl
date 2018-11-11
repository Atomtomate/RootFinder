module RootFinder
using ForwardDiff

    struct NotConvergedException <: Exception end

    function main()
    end

    function fixedPointIteration(f, start_x, atol = 1e-8)
        x = start_x
        xnew = f(x)
        while abs(x - xnew) > 1e-8
            x = xnew
            xnew = f(x)
        end
        xnew
    end

    function df_val(f, x)
        df = y -> ForwardDiff.derivative(f, y)
        [f(x), df(x)]
    end

    function newtonStep(f, x)
        fdf = df_val(f, x)
        x - fdf[1]/fdf[2]
    end

    function newtonMethod(f, start_x = 0, atol = 1e-8)
        res = fixedPointIteration(x -> newtonStep(f, x) , start_x, atol)
        if !isfinite(res)
            throw(NotConvergedException)
        end
        res
    end

    function secantMethod(f, start_x = -10, start_xp = 10, atol = 1e-8)
        x = start_x
        x_old = start_xp
        m = (f(x) - f(x_old))/(x-x_old)
        tmp = x
        x = x - 
    end

end
