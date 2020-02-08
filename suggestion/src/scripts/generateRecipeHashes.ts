import * as fs from 'fs';
import * as path from 'path';

/**
 * Randomly generates `size` binary numbers with each binary number having `hashLength` bits.
 * @param size - Number of hashes generated
 * @param hashLength - Number of bits of each hash
 */
function generateRecipeHashes(size: number, hashLength: number = 16) {
    const result = Array.from({ length: size }).fill(-1);
    return result.map(() => {
        let hash = '';
        while (hash.length < hashLength) {
            const nextBit = getRandomBoolean() ? '1' : '0';
            hash += nextBit;
        }
        return parseInt(hash, 2);
    });
}

function getRandomBoolean() {
    return Math.random() > 0.5;
}

// Save hashes as a list of binary strings
const hashes = generateRecipeHashes(50).map((num) => num.toString(2));
fs.writeFileSync(path.resolve('mocks/hashes.json'), JSON.stringify(hashes));
