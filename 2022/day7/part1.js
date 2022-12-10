const fs = require('fs');


/**
 * This should return us an object like:
 * {
 *   'a': {directories: [ 'b' ], size: number },
 *   'b': {directories: [], size: number }
 *   'c': {directories: [], size: number }
 * }
 */
const parseInput = (input) => {
    const lines = input.split("\n")
    const fileSystem = {}
    const path = [] // string[]

    for (const line of lines) {

        // This is a command
        if (line.startsWith('$')) {

            // Move to another directory
            if (line.startsWith('$ cd')) {

                if (line.startsWith('$ cd ..')) {
                    path.pop()
                } else {
                    const directory = line.replace('$ cd ', '')
                    path.push(directory)

                    if (! fileSystem[directory]) {
                        fileSystem[path.join('/')] = { directories: [], size: 0 }
                    }
                }

            } else if (line.startsWith('$ ls')) {
                continue // Nothing to do
            }
        } else {
            // This is not a command! We must be listing files...

            // There is a sub-directory
            if (line.startsWith('dir')) {
                const directory = line.replace('dir ', '')
                fileSystem[path.join('/')].directories.push(directory)
            } else {
                // This must be a file!
                const fileSize = parseInt(line.split(' ')[0])
                if (! isNaN(fileSize)) {
                    // Record this size in all parent directories (including the current directory)
                    for (let i = 0; i < path.length; i++) {
                        const key = path.slice(0, i + 1).join('/')
                        fileSystem[key].size += fileSize
                    }
                }
            }
        }
    }

    return fileSystem
}




const solve = () => {
    const input = fs.readFileSync('input.txt', 'utf8');
    const fileSystem = parseInput(input)
    
    let result = 0
    for (const directory of Object.values(fileSystem)) {
        if (directory.size <= 100000) {
            result += directory.size
        }
    }

    console.log(result)
}

solve()