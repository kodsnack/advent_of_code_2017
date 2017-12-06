
clear all


size = 30
matrix = zeros(size,size);
stopNext = 0;
x = size / 2;
y = size / 2;
matrix(x, y) = 1;
x = x + 1;
currentDirection = 'right';
for i = 1:1:400
    
	matrix(x,y) = matrix(x - 1, y + 1) + matrix(x, y + 1) + matrix(x + 1, y + 1) + matrix(x - 1 , y) + matrix(x + 1 , y) + matrix(x - 1, y - 1) + matrix(x, y - 1) + matrix(x + 1, y - 1);

    if (matrix(x,y) > 361527)
        matrix(x,y)
        break;
    end
    
    if(strcmp(currentDirection,'right'))
        if((x + y) == (size + 1))
            currentDirection = 'up'
            y = y + 1;
        else
            x = x + 1;
        end
    elseif(strcmp(currentDirection,'up'))
        if(x == y)
            currentDirection = 'left'
            x = x - 1;
        else
            y = y + 1;
        end
    elseif(strcmp(currentDirection,'left'))
        if((x + y) == size)
            currentDirection = 'down'
            y = y - 1;
        else
            x = x - 1;
        end   
	elseif(strcmp(currentDirection,'down'))
        if(x == y)
            currentDirection = 'right'
            x = x + 1;
        else
            y = y - 1;
        end 
    end
    

end





