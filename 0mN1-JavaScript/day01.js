let d1_1=(x)=>[...x,x[0]].reduce((p,n,i,a)=>n==a[i-1]?p+~~n:p,0)
let d1_2=(x,l)=>(l=x.length/2)&&[...x].reduce((p,n,i,a)=>n==a[i+l*(i<l?1:-1)]?p+~~n:p,0)