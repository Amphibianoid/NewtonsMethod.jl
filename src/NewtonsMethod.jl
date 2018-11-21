module NewtonsMethod

greet() = print("Hello World!")

    using Expectations, Distributions, ForwardDiff, LinearAlgebra

function foo(μ = 1., σ = 2.)
    d = Normal(μ, σ)
    E = expectation(d)
    return E(x -> sin(x))
end

export foo

    function newtonroot(f,f′; x₀,tol=1E-7,maxiter=1000)
        x_old=x₀
        iter=0
        diff=1000
        while diff>tol && iter<=maxiter
            x_new=x_old-f(x_old)/f′(x_old)
            iter=iter+1
            diff=norm(x_old-x_new)
            x_old=x_new
        end
        if iter<maxiter
            return x_old
        else
            return nothing
        end
    end
D(f)= x -> ForwardDiff.derivative(f, x)

newtonroot(f;x₀,tol=1E-7,maxiter=1000)=newtonroot(f,D(f),x₀=x₀,tol=tol,maxiter=maxiter)

export newtonroot

end # module
