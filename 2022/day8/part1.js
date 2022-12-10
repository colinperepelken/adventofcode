const fs = require('fs');


const isVisible = (list, tree) => {
    for (value of list) {
        if (parseInt(value) >= parseInt(tree)) {
            return false
        }
    }

    return true
}

const input = fs.readFileSync('input.txt', 'utf8');


const grid = input.split("\n").map(line => line.split(''))
grid.pop() // remove last row, it is empty

let visibleCount = 0

for (let rowIndex = 0; rowIndex < grid.length; rowIndex++) {
    row = grid[rowIndex]
    for (let colIndex = 0; colIndex < row.length; colIndex++) {
        if (colIndex === 0  || colIndex === row.length -1 || rowIndex === 0 || rowIndex === grid.length - 1) {
            visibleCount++
            continue
        }

        const tree = row[colIndex]

        const column = grid.map(row => row[colIndex]);

        const columnUp = column.slice(0, rowIndex )
        const columnDown = column.slice(rowIndex + 1, column.length)

        const rowLeft = row.slice(0, colIndex)
        const rowRight= row.slice(colIndex + 1, row.length)

        
        if (isVisible(columnUp, tree) || isVisible(columnDown, tree) || isVisible(rowLeft, tree) || isVisible(rowRight, tree)) {
            visibleCount++
            continue
        }

    }
}

console.log(visibleCount)
