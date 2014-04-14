%verfiy the calculation in C++ using same coordinate

sec3x_far=[953.6, 819.624554716761, 989.3,948.1, 919.7, ...,
    926.5, 923.7, 941.4, 927.34, 779.8,937.8,886.8, 953.6, 904, 979.3,769, 892.2, 827.8, 922.3, 788.1];

sec3y_far=1000*[1.6819    1.4909    1.4582    1.7104    1.6031    1.2169    1.3687    1.623,1.6015, ...,
    1.4651    1.3357    1.2737    1.3296    1.4518    1.3521    1.2287    1.4497,  1.4812,1.598,1.6393];

Rb_dch =  64*ones(1,length(c1));

UserCoordinates_3t = [sec3x_far; sec3y_far];

siteDistance =3;
Pdch_sec3_far = PtDCH(Rb_dch,UserCoordinates_3t, siteDistance);  % 27.6367 W
Pfach_sec3_far = PtFACH(64, UserCoordinates_3t, siteDistance);    % 10.182 W
[Phs__sec3_far,numCode,allocBw] = PtHS(Rb_dch,UserCoordinates_3t,siteDistance); % 11.6548W

