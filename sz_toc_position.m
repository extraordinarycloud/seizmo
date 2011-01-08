function []=sz_toc_position()
% Global Positioning & Conversion Functions
%<a href="matlab:help arraycenter">arraycenter</a>              - Returns the geographic center of an array
%<a href="matlab:help arrayaperture">arrayaperture</a>            - Returns the aperture of an array
%<a href="matlab:help authalic2geographiclat">authalic2geographiclat</a>   - Convert latitude from authalic to geographic
%<a href="matlab:help closest_point_on_gc">closest_point_on_gc</a>      - Return closest point on great circle to a point
%<a href="matlab:help degdist_from_gc">degdist_from_gc</a>          - Distance from a point on a sphere to a great circle
%<a href="matlab:help enu2geographic">enu2geographic</a>           - Converts local East/North/Up system to geographic
%<a href="matlab:help fixlatlon">fixlatlon</a>                - Returns latitudes & longitudes in reasonable ranges
%<a href="matlab:help gc2latlon">gc2latlon</a>                - Returns points along great circle(s)
%<a href="matlab:help gcarc2latlon">gcarc2latlon</a>             - Returns points along great circle arc(s)
%<a href="matlab:help gc_intersect">gc_intersect</a>             - Return intersection points between great circles
%<a href="matlab:help gcarc_intersect">gcarc_intersect</a>          - Return intersection points between great circle arcs
%<a href="matlab:help geocentric2geographiclat">geocentric2geographiclat</a> - Convert latitude from geocentric to geographic
%<a href="matlab:help geocentric2geographic">geocentric2geographic</a>    - Converts coordinates from geocentric to geographic
%<a href="matlab:help geocentric2xyz">geocentric2xyz</a>           - Converts coordinates from geocentric to cartesian
%<a href="matlab:help geographic2authaliclat">geographic2authaliclat</a>   - Convert latitude from geographic to authalic
%<a href="matlab:help geographic2enu">geographic2enu</a>           - Converts geographic to local East/North/Up system
%<a href="matlab:help geographic2geocentriclat">geographic2geocentriclat</a> - Convert latitude from geographic to geocentric
%<a href="matlab:help geographic2geocentric">geographic2geocentric</a>    - Converts coordinates from geographic to geocentric
%<a href="matlab:help geographic2xyz">geographic2xyz</a>           - Converts coordinates from geographic to cartesian
%<a href="matlab:help geographiclat2radius">geographiclat2radius</a>     - Returns the radius at a geographic latitude
%<a href="matlab:help gridconv">gridconv</a>                 - Calculates grid convergence for orthographic projection
%<a href="matlab:help haversine">haversine</a>                - Returns distance between 2 points using the Haversine formula
%<a href="matlab:help latmod">latmod</a>                   - Returns a latitude modulus (ie unwraps latitudes)
%<a href="matlab:help lonmod">lonmod</a>                   - Returns a longitude modulus (ie unwraps longitudes)
%<a href="matlab:help mean_ellipsoid_radius">mean_ellipsoid_radius</a>    - Returns the mean radius of an ellipsoid
%<a href="matlab:help randlatlon">randlatlon</a>               - Returns lat/lon points uniformly distributed on a sphere
%<a href="matlab:help sphericalfwd">sphericalfwd</a>             - Finds a point on a sphere relative to another point
%<a href="matlab:help sphericalinv">sphericalinv</a>             - Return distance and azimuth between 2 locations on sphere
%<a href="matlab:help vincentyfwd">vincentyfwd</a>              - Find destination point on an ellipsoid relative to a point
%<a href="matlab:help vincentyinv">vincentyinv</a>              - Find distance and azimuth between 2 locations on ellipsoid
%<a href="matlab:help xyz2geocentric">xyz2geocentric</a>           - Converts coordinates from cartesian to geocentric
%<a href="matlab:help xyz2geographic">xyz2geographic</a>           - Converts coordinates from cartesian to geographic
%
% <a href="matlab:help seizmo">SEIZMO - Passive Seismology Toolbox</a>
end
