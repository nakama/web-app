// a trivial hash function
function hash(str, hashSize)
{
    var result = 0; 
    
    for(var i = 0; i < str.length; i++) 
        result += str.charCodeAt(i) + 31 * result;
    
    return result % hashSize;
}