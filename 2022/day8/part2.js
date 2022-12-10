const fs = require('fs');


const calculateScenicScore = (list, tree) => {
    let score = 0
    for (value of list) {
        score++
        if(value >= tree) {
            return score
        }
    }

    return score
}

const input = fs.readFileSync('input.txt', 'utf8');


const grid = input.split("\n").map(line => line.split(''))
grid.pop() // remove last row, it is empty

let maxScenicScore = 0

for (let rowIndex = 0; rowIndex < grid.length; rowIndex++) {
    row = grid[rowIndex]
    for (let colIndex = 0; colIndex < row.length; colIndex++) {
        const tree = row[colIndex]

        const column = grid.map(row => row[colIndex]);

        const columnUp = column.slice(0, rowIndex ).reverse()
        const columnDown = column.slice(rowIndex + 1, column.length)

        const rowLeft = row.slice(0, colIndex).reverse()
        const rowRight= row.slice(colIndex + 1, row.length)

        scores = []
        for (const list of [columnUp, columnDown, rowLeft, rowRight]) {
            scores.push(calculateScenicScore(list, tree))
        }

        const scenicScore = scores.reduce((result, score) => score * result)
        
        if (scenicScore > maxScenicScore) {
            maxScenicScore = scenicScore
        }

    }
}

console.log(maxScenicScore)
