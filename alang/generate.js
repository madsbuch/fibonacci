function generate(n){
    if (n === 0)
        return "(Lit 0)"
    if (n === 1)
        return "(Lit 1)"
    return "(Add " + generate(n-1) + " " + generate(n-2) + " )"
}

console.log(generate(20))