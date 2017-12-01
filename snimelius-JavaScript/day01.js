const solvePuzzleOne = (input) => {
    let splittedInput = input.toString().split('');
    let matches = [];
    splittedInput.forEach((element, index) => {
        if ( element === splittedInput[index + 1] )
            matches.push(+element);
        if ( index === splittedInput.length - 1) {
            if ( element === splittedInput[0] )
                matches.push(+element);
        }
    });
    return matches.reduce((p,c) => p+c,0);
};

const solvePuzzleTwo = (input) => {
    let splittedInput = input.toString().split('');
    let matches = [];
    let step = splittedInput.length / 2;
    splittedInput.forEach((element, index) => {
        let nextIndex = index + step;
        if ( nextIndex > splittedInput.length - 1 )
            nextIndex -= splittedInput.length;
        if ( element === splittedInput[nextIndex] )
            matches.push(+element);
    });
    return matches.reduce((p,c) => p+c,0);
};