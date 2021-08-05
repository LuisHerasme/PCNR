function ang = angle(v1, v2)
    ang = acosd( dot(v1, v2) / ( norm(v1) * norm(v2) ) );
end