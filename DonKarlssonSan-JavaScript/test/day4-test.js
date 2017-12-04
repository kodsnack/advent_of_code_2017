let validator = require("../day4-passphrase-validator");
let expect = require("chai").expect;

describe("Day 4, Part 1 - isValid(passphrase)", function () {
    it("should be valid - unique", function () {
        let passphrase = "aa bb cc dd ee"; 
        let isValid = validator.isValid(passphrase);
        expect(isValid).to.be.true;
    });

    it("should not be valid - not unique", function () {
        let passphrase = "aa bb cc dd aa"; 
        let isValid = validator.isValid(passphrase);
        expect(isValid).to.be.false;
    });

    it("should be valid, aa != aaa", function () {
        let passphrase = "aa bb cc dd aaa"; 
        let isValid = validator.isValid(passphrase);
        expect(isValid).to.be.true;
    });
});

describe("Day 4, Part 1 - nrOfValidPassphrasesInFile(path)", function () {
    it("should return 2 valid", function () {
        const passphraseFile = "day4-testdata-passphrases.txt"; 
        const path = require("path");
        const filepath = path.join(__dirname, passphraseFile);        
        const nrOfValid = validator.nrOfValidPassphrasesInFile(filepath);
        expect(nrOfValid).to.be.equal(2);
    });
    
    // it("Result", function () {
    //     const passphraseFile = "day4-passphrases.txt"; 
    //     const path = require("path");
    //     const filepath = path.join(__dirname, passphraseFile);        
    //     const nrOfValid = validator.nrOfValidPassphrasesInFile(filepath);
    //     console.log(nrOfValid);
    // });
});

describe("Day 4, Part 2", function () {
    it("should be valid - unique", function () {
        let passphrase = "abcde fghij"; 
        let isValid = validator.isValid2(passphrase);
        expect(isValid).to.be.true;
    });

    it("should not be valid - first and third word are anagrams", function () {
        let passphrase = "abcde xyz ecdab"; 
        let isValid = validator.isValid2(passphrase);
        expect(isValid).to.be.false;
    });

    // it("Result", function () {
    //     const passphraseFile = "day4-passphrases.txt"; 
    //     const path = require("path");
    //     const filepath = path.join(__dirname, passphraseFile);        
    //     const nrOfValid = validator.nrOfValidPassphrasesInFile2(filepath);
    //     console.log(nrOfValid);
    // });
});
