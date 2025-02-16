@DB
Feature: Import of address interpolations
    Tests that interpolated addresses are added correctly

    Scenario: Simple even interpolation line with two points
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  | 2       | 1 1 |
          | N2  | place | house  | 6       | 1 1.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 1 1, 1 1.001 |
        And the ways
          | id | nodes |
          | 1  | 1,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 4   | 1 1.0005 |

    Scenario: Backwards even two point interpolation line
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  | 2       | 1 1 |
          | N2  | place | house  | 8       | 1 1.003 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 1 1.003, 1 1 |
        And the ways
          | id | nodes |
          | 1  | 2,1 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 6   | 1 1.001, 1 1.002 |

    Scenario: Simple odd two point interpolation
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  | 1       | 1 1 |
          | N2  | place | house  | 11      | 1 1.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | odd     | 1 1, 1 1.001 |
        And the ways
          | id | nodes |
          | 1  | 1,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 3     | 9  | 1 1.0002, 1 1.0008 |

    Scenario: Simple all two point interpolation
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  | 1       | 1 1 |
          | N2  | place | house  | 4       | 1 1.003 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | all     | 1 1, 1 1.003 |
        And the ways
          | id | nodes |
          | 1  | 1,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 2     | 3   | 1 1.001, 1 1.002 |

    Scenario: Even two point interpolation line with intermediate empty node
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  | 2       | 1 1 |
          | N2  | place | house  | 10      | 1.001 1.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 1 1, 1 1.001, 1.001 1.001 |
        And the ways
          | id | nodes |
          | 1  | 1,3,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 8   | 1 1.0005, 1 1.001, 1.0005 1.001 |

    Scenario: Even two point interpolation line with intermediate duplicated empty node
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  | 2       | 1 1 |
          | N2  | place | house  | 10      | 1.001 1.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 1 1, 1 1.001, 1.001 1.001 |
        And the ways
          | id | nodes |
          | 1  | 1,3,3,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 8   | 1 1.0005, 1 1.001, 1.0005 1.001 |

    Scenario: Simple even three point interpolation line
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  | 2       | 1 1 |
          | N2  | place | house  | 14      | 1.001 1.001 |
          | N3  | place | house  | 10      | 1 1.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 1 1, 1 1.001, 1.001 1.001 |
        And the ways
          | id | nodes |
          | 1  | 1,3,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     |  8  | 1 1.00025, 1 1.00075 |
          | 12    | 12  | 1.0005 1.001 |

    Scenario: Simple even four point interpolation line
        Given the places
          | osm | class | type  | housenr | geometry |
          | N1  | place | house | 2       | 1 1 |
          | N2  | place | house | 14      | 1.001 1.001 |
          | N3  | place | house | 10      | 1 1.001 |
          | N4  | place | house | 18      | 1.001 1.002 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 1 1, 1 1.001, 1.001 1.001, 1.001 1.002 |
        And the ways
          | id | nodes |
          | 1  | 1,3,2,4 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 8   | 1 1.00025, 1 1.00075 |
          | 12    | 12  | 1.0005 1.001 |
          | 16    | 16  | 1.001 1.0015 |

    Scenario: Reverse simple even three point interpolation line
        Given the places
          | osm | class | type  | housenr | geometry |
          | N1  | place | house | 2       | 1 1 |
          | N2  | place | house | 14      | 1.001 1.001 |
          | N3  | place | house | 10      | 1 1.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 1.001 1.001, 1 1.001, 1 1 |
        And the ways
          | id | nodes |
          | 1  | 2,3,1 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     |  8  | 1 1.00025, 1 1.00075 |
          | 12    | 12  | 1.0005 1.001 |

    Scenario: Even three point interpolation line with odd center point
        Given the places
          | osm | class | type  | housenr | geometry |
          | N1  | place | house | 2       | 1 1 |
          | N2  | place | house | 8       | 1.001 1.001 |
          | N3  | place | house | 7       | 1 1.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 1 1, 1 1.001, 1.001 1.001 |
        And the ways
          | id | nodes |
          | 1  | 1,3,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 6   | 1 1.0004, 1 1.0008 |

    Scenario: Interpolation line with self-intersecting way
        Given the places
          | osm | class | type  | housenr | geometry |
          | N1  | place | house | 2       | 0 0 |
          | N2  | place | house | 6       | 0 0.001 |
          | N3  | place | house | 10      | 0 0.002 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 0 0, 0 0.001, 0 0.002, 0 0.001 |
        And the ways
          | id | nodes |
          | 1  | 1,2,3,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 4   | 0 0.0005 |
          | 8     | 8   | 0 0.0015 |
          | 8     | 8   | 0 0.0015 |

    Scenario: Interpolation line with self-intersecting way II
        Given the places
          | osm | class | type  | housenr | geometry |
          | N1  | place | house | 2       | 0 0 |
          | N2  | place | house | 6       | 0 0.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 0 0, 0 0.001, 0 0.002, 0 0.001 |
        And the ways
          | id | nodes |
          | 1  | 1,2,3,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 4   | 0 0.0005 |

    Scenario: addr:street on interpolation way
        Given the scene parallel-road
        And the places
          | osm | class | type  | housenr | geometry |
          | N1  | place | house | 2       | :n-middle-w |
          | N2  | place | house | 6       | :n-middle-e |
          | N3  | place | house | 12      | :n-middle-w |
          | N4  | place | house | 16      | :n-middle-e |
        And the places
          | osm | class   | type    | addr+interpolation | street       | geometry |
          | W10 | place   | houses  | even    |              | :w-middle |
          | W11 | place   | houses  | even    | Cloud Street | :w-middle |
        And the places
          | osm | class   | type     | name         | geometry |
          | W2  | highway | tertiary | Sun Way      | :w-north |
          | W3  | highway | tertiary | Cloud Street | :w-south |
        And the ways
          | id | nodes |
          | 10  | 1,100,101,102,2 |
          | 11  | 3,200,201,202,4 |
        When importing
        Then placex contains
          | object | parent_place_id |
          | N1     | W2 |
          | N2     | W2 |
          | N3     | W3 |
          | N4     | W3 |
        Then W10 expands to interpolation
          | parent_place_id | start | end |
          | W2              | 4     | 4 |
        Then W11 expands to interpolation
          | parent_place_id | start | end |
          | W3              | 14    | 14 |
        When sending search query "16 Cloud Street"
        Then results contain
         | ID | osm_type | osm_id |
         | 0  | N        | 4 |
        When sending search query "14 Cloud Street"
        Then results contain
         | ID | osm_type | osm_id |
         | 0  | W        | 11 |

    Scenario: addr:street on housenumber way
        Given the scene parallel-road
        And the places
          | osm | class | type  | housenr | street       | geometry |
          | N1  | place | house | 2       |              | :n-middle-w |
          | N2  | place | house | 6       |              | :n-middle-e |
          | N3  | place | house | 12      | Cloud Street | :n-middle-w |
          | N4  | place | house | 16      | Cloud Street | :n-middle-e |
        And the places
          | osm | class   | type    | addr+interpolation | geometry |
          | W10 | place   | houses  | even               | :w-middle |
          | W11 | place   | houses  | even               | :w-middle |
        And the places
          | osm | class   | type     | name         | geometry |
          | W2  | highway | tertiary | Sun Way      | :w-north |
          | W3  | highway | tertiary | Cloud Street | :w-south |
        And the ways
          | id  | nodes |
          | 10  | 1,100,101,102,2 |
          | 11  | 3,200,201,202,4 |
        When importing
        Then placex contains
          | object | parent_place_id |
          | N1     | W2 |
          | N2     | W2 |
          | N3     | W3 |
          | N4     | W3 |
        Then W10 expands to interpolation
          | parent_place_id | start | end |
          | W2              | 4     | 4 |
        Then W11 expands to interpolation
          | parent_place_id | start | end |
          | W3              | 14    | 14 |
        When sending search query "16 Cloud Street"
        Then results contain
         | ID | osm_type | osm_id |
         | 0  | N        | 4 |
        When sending search query "14 Cloud Street"
        Then results contain
         | ID | osm_type | osm_id |
         | 0  | W        | 11 |

    Scenario: Geometry of points and way don't match (github #253)
        Given the places
          | osm | class | type        | housenr | geometry |
          | N1  | place | house       | 10      | 144.9632341 -37.76163 |
          | N2  | place | house       | 6       | 144.9630541 -37.7628174 |
          | N3  | shop  | supermarket | 2       | 144.9629794 -37.7630755 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even    | 144.9632341 -37.76163,144.9630541 -37.7628172,144.9629794 -37.7630755 |
        And the ways
          | id | nodes |
          | 1  | 1,2,3 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 4     | 4   | 144.963016 -37.762946 |
          | 8     | 8   | 144.963144 -37.7622237 |

    Scenario: Place with missing address information
        Given the grid
          | 1 |  | 2 |  |  | 3 |
        And the places
          | osm | class   | type   | housenr |
          | N1  | place   | house  | 23      |
          | N2  | amenity | school |         |
          | N3  | place   | house  | 29      |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | odd                | 1,2,3 |
        And the ways
          | id | nodes |
          | 1  | 1,2,3 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 25    | 27  | 0.000016 0,0.00002 0,0.000033 0 |

    Scenario: Ways without node entries are ignored
        Given the places
          | osm | class | type   | housenr | geometry |
          | W1  | place | houses | even    | 1 1, 1 1.001 |
        When importing
        Then W1 expands to no interpolation

    Scenario: Ways without nodes without housenumbers are ignored
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  |         | 1 1 |
          | N2  | place | house  |         | 1 1.001 |
          | W1  | place | houses | even    | 1 1, 1 1.001 |
        When importing
        Then W1 expands to no interpolation

    Scenario: Two point interpolation starting at 0
        Given the places
          | osm | class | type   | housenr | geometry |
          | N1  | place | house  | 0       | 1 1 |
          | N2  | place | house  | 10      | 1 1.001 |
        And the places
          | osm | class | type   | addr+interpolation | geometry |
          | W1  | place | houses | even     | 1 1, 1 1.001 |
        And the ways
          | id | nodes |
          | 1  | 1,2 |
        When importing
        Then W1 expands to interpolation
          | start | end | geometry |
          | 2     | 8   | 1 1.0002, 1 1.0008 |
        When sending jsonv2 reverse coordinates 1,1
        Then results contain
          | ID | osm_type | osm_id | type  | display_name |
          | 0  | node     | 1      | house | 0 |
