/**
 * Randomly generates `size` binary numbers with each binary number having `hashLength` bits.
 * @param size - Number of hashes generated
 * @param hashLength - Number of bits of each hash
 */
function generateRecipeHashes(size: number, hashLength: number = 16) {
    const hashes = Array.from({ length: size }).fill(-1);
    return hashes.map(() => {
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

// Exports 50 random hashes by default
export default generateRecipeHashes(50);
