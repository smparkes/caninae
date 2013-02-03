#!/usr/bin/env sh

rails g scaffold location \
 street:string \
 city:string \
 state:string \
 country:string \
 latitude:float \
 longitude:float \
 resolution:float \

rails g scaffold event \
 entity_id: int \
 entity_type: string \
 type:string \
 date:date \
 time:time \
 location_id:location \

rails g scaffold animal \
 name:string \
 call_name:string \
 mother_id:int \
 father_id:int \
 sex:string \
 litter_id:int \
 address_id:int \
 birth_id:int \
 death_id:int \

rails g scaffold clearance \
 animal_id:int \

rails g scaffold animal_owner \
 animal_id:int \
 owner_id:int \

rails g scaffold animal_breeder \
 animal_id:int \
 breeder_id:int \

rails g scaffold animal_kennel \
 animal_id:int \
 kennel_id:int \

rails g scaffold registration \
 registry_id:int \
 animal_id:int \
 registration_number:int \
 date:date \

rails g scaffold person \
 first_name:string \
 last_name:string \
 address_id:int \
    
rails g scaffold kennel \
 name:string \
 address_id:int \

rails g scaffold person_kennel \
 person_id:int \
 kennel_id:int \

rails g scaffold kennel_litter \
 kennel_id:int \
 litter_id:int \

rails g scaffold litter \
 mother_id:int \
 father_id:int \
 event_id:int \
 name:string \

rails g scaffold pup_litter \
 litter_id:int \
 offspring_id:int \

rails g scaffold certification \
 
rails g scaffold achievement \
 title_id:int \
 event_id:int \

rails g scaffold title \
 registry_id:int \
 name:string \
 abbreviation:string \
 prefix:boolean \

rails g scaffold dominates \
 dominator_id:int \
 dominated_id:int \

rails g scaffold preceeds \
 first:int \
 second:int \

rails g scaffold succeeds \
 first:int \
 second:int \
