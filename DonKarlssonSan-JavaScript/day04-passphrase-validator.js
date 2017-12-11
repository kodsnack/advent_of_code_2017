function isValid(phrase) {
    let words = phrase.split(' ');
    let uniqueWords = new Set(words);
    return uniqueWords.size === words.length;
}

function isValid2(phrase) {
    let words = phrase.split(' ');
    let wordsSorted = words.map(w => w.split('').sort().join(''));
    let uniqueWords = new Set(wordsSorted);
    return uniqueWords.size === words.length;
}

function nrOfValidPassphrasesInFile(path) {
    return nrOfValidPassphrasesInFileUsingValidator(path, isValid);
}

function nrOfValidPassphrasesInFile2(path) {
    return nrOfValidPassphrasesInFileUsingValidator(path, isValid2);
}

function nrOfValidPassphrasesInFileUsingValidator(path, validator) {
    let fs = require('fs');
    let allPhrases = fs.readFileSync(path, 'utf8');
    let endOfLine = require('os').EOL;
    let phrases = allPhrases.split(endOfLine);
    let nrOfValid = 0;
    phrases.forEach(p => {
        if(validator(p)) {
            nrOfValid++;
        }
    });
    return nrOfValid;
}


module.exports.isValid = isValid;
module.exports.isValid2 = isValid2;
module.exports.nrOfValidPassphrasesInFile = nrOfValidPassphrasesInFile;
module.exports.nrOfValidPassphrasesInFile2 = nrOfValidPassphrasesInFile2;
