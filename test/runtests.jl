using NewtonsMethod
using Test
using LinearAlgebra

@testset "NewtonTests" begin

# Testing first function

g(x)=(x-1)^2
g′(x)=2*(x-1)
@test newtonroot(g,g′;x₀=2) ≈ 1.0 atol=1E-4
@test newtonroot(g;x₀=2)  ≈ 1.0 atol=1E-4

#Testing second function

h(x)=exp(x)-1
h′(x)=exp(x)
@test newtonroot(h,h′;x₀=3) ≈ 0.0 atol=1E-4
@test newtonroot(h;x₀=3) ≈ 0.0  atol=1E-4

#Testing function without convergence

j(x)=x^2+2
j′(x)=2*x

@test newtonroot(j,j′;x₀=1) == nothing
@test newtonroot(j;x₀=1) == nothing

#Testing maxiter

@test newtonroot(h,h′;x₀=3,maxiter=5) == nothing

#Testing tolerance
#From above
@test newtonroot(h,h′;x₀=3,tol=1E10) == 3

#From below
root1=newtonroot(g,g′;x₀=3,tol=1E-6)
root2=newtonroot(g,g′;x₀=3)
@test norm(root1-1)>norm(root2-1)

#Testing BigFloat

@test newtonroot(h,h′;x₀=BigFloat(3),tol=BigFloat(1E-7),maxiter=BigFloat(1000)) ≈ 0.0 atol=1E-4

l(x)=log(x)

@test_broken newtonroot(l;x₀=3) ≈ 1.0 atol=1E-4

end
