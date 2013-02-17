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
 entity_id: integer \
 entity_type: string \
 event_type:string \
 date:date \
 time:time \
 location_id:integer \

rails g scaffold animal_parent \
 offspring_id:integer \
 parent_id:integer \
 mother:boolean

rails g scaffold animal \
 name:string \
 call_name:string \
 mother_id:integer \
 father_id:integer \
 sex:string \
 litter_id:integer \
 address_id:integer \
 import_json:string \

rails g scaffold clearance \
 animal_id:integer \

rails g scaffold animal_owner \
 animal_id:integer \
 owner_id:integer \

rails g scaffold animal_breeder \
 animal_id:integer \
 breeder_id:integer \

rails g scaffold animal_kennel \
 animal_id:integer \
 kennel_id:integer \

rails g scaffold registration \
 registry_id:integer \
 animal_id:integer \
 registration_number:integer \
 date:date \

rails g scaffold person \
 first_name:string \
 last_name:string \
 address_id:integer \
    
rails g scaffold kennel \
 name:string \
 address_id:integer \

rails g scaffold person_kennel \
 person_id:integer \
 kennel_id:integer \

rails g scaffold kennel_litter \
 kennel_id:integer \
 litter_id:integer \

rails g scaffold litter \
 mother_id:integer \
 father_id:integer \
 event_id:integer \
 name:string \

rails g scaffold offspring_litter \
 litter_id:integer \
 offspring_id:integer \

rails g scaffold certification \
 
rails g scaffold achievement \
 title_id:integer \
 event_id:integer \

rails g scaffold title \
 registry_id:integer \
 name:string \
 abbreviation:string \
 prefix:boolean \

rails g scaffold dominates \
 dominator_id:integer \
 dominated_id:integer \

rails g scaffold preceeds \
 first:integer \
 second:integer \

rails g scaffold succeeds \
 first:integer \
 second:integer \
