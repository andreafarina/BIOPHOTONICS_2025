function A = Afactor(n_ext,n_int)

n_rel = n_int / n_ext;
if (n_rel<=1)
    A = 3.084635-6.531194*n_rel+8.357854*n_rel^2-5.082751*n_rel^3+1.171382*n_rel^4;
else
    A = 504.332889-2641.00214*n_rel+5923.699064*n_rel^2-7376.355814*n_rel^3+5507.53041*n_rel^4-2463.357945*n_rel^5+610.956547*n_rel^6-64.8047*n_rel^7;
end