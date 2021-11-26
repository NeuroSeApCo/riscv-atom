function [acc, apx, diff] = ADD(x, y)
    acc = x+y;
    apx = acep(x, y, 32, 4);
    diff = acc-apx;
end