export const snakeToCamel = (str: string) =>
    str
        .toLowerCase()
        .replace(/[-_][a-z]/g, (group) => group.slice(-1).toUpperCase())
