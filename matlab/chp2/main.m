n = [];
err = [];
conds = [];
for k=1:11
    n(k) = 10 * 2^k;
    [mat, err(k)] =  beam(n(k));
    conds(k) = condest(mat);
end

conds
err
plot(n, err)