;Template definitions -- applicant details



(deftemplate applicant 

    (slot name)

    (slot age)

   	(slot marital_status)

    (slot has_family_citizen)

    (slot has_family_greencard)

)



(deftemplate family_citizen

    (slot name) 

    (slot age) 

    (slot relation) 

)



(deftemplate family_greencard

    (slot name) 

    (slot age) 

    (slot relation) 

)

(deftemplate employment_based

    (slot EB1) 

    (slot EB2) 

    (slot EB2NationalInterest) 
    
    (slot EB3) 
    
    (slot EB4) 
    
    (slot EB5) 

)

;Template definitions -- applicant details



(deftemplate applicant 

    (slot name)

    (slot age)

   	(slot marital_status)

    (slot has_family_citizen)

    (slot has_family_greencard)

)



(deftemplate family_citizen

    (slot name) 

    (slot age) 

    (slot relation) 

)



(deftemplate family_greencard

    (slot name) 

    (slot age) 

    (slot relation) 

)

(deftemplate employment_based

    (slot EB1) 

    (slot EB2) 

    (slot EB2NationalInterest) 
    
    (slot EB3) 
    
    (slot EB4) 
    
    (slot EB5) 

)


(deftemplate refugee

    (slot outside_country_citizen )

    (slot is_at_the_border))





(deftemplate cuban

    (slot native_citizen )

    (slot spouse_or_child ))





(deftemplate diversity

    (slot inlist)


    )

(deftemplate inputTaken 

    (slot inp)

    (slot isValid)

)   

(deftemplate execution 

    (slot isComplete)

)

(deftemplate validSkill)

(defglobal

    ?*AppName* = ""

    ?*AppAge* = 0

    ?*AppMaritalStatus* =  0

    ?*AppHasFamilyCitizen* = 0

    ?*AppHasFamilyGreencard* = 0

    ?*CitizenName* = ""

    ?*CitizenAge* = 0

    ?*CitizenRelation* = 0

    ?*GreencardHolderName* = ""

    ?*GreencardHolderAge* = 0

    ?*GreencardHolderRelation* = 0

    ?*inpTaken* = 0  

    ?*isValidInp* = ""

    ?*isExecuted* = 0 

    ?*FamilyQualifier* = ""
    
    ?*EB1* = 0 
    
    ?*EB2* = 0 
    
    ?*EB2NationalInterest* = 0 
    
    ?*EB3* = 0 
    
    ?*EB4* = 0 
    
    ?*EB5* = 0 
    

    ?*OutsideCountry* = 0

    ?*AtBorder* = 0

    ?*diversity*  = 0

    ?*cubnaNative*  = 0

    ?*cubanRelated*  = 0

    )

(defrule checkForFamilyCategory

    =>

    (printout t crlf crlf "****WELCOME TO THE GREEN CARD DECISION MAKER BOT****" crlf)

    (printout t "$$ This application uses the user applicant's information to decide what kind of a visa he will get and is rejected if he doesn't qualify for that visa" crlf)

    (printout t "**NOTE: PLEASE PROVIDE A VALID INPUT FOR ALL THE QUESTIONS. REFER THE DOCUMENTATION FOR MORE INFO ON HOW TO USE THIS APPLICATION" crlf)

    (printout t "**************Applicant Info Section*****************" crlf crlf)        

    (printout t "Please enter your name: " crlf)

    (bind ?*AppName* (read t))

    (printout t "What is your age?" crlf)

    (bind ?*AppAge* (read t))

    (printout t "Are you married?[for yes, input 1/ for no, input 0]" crlf)

    (bind ?*AppMaritalStatus* (read t))

    (printout t "Do you have a US Citizen in your immediate family?[for yes, input 1/ for no, input 0]" crlf)

    (bind ?*AppHasFamilyCitizen* (read t))

    (printout t "Do you have a green card holder in your immediate family?[for yes, input 1/ for no, input 0]" crlf)

    (bind ?*AppHasFamilyGreencard* (read t))

    (assert (applicant (name ?*AppName*) (age ?*AppAge*) (marital_status ?*AppMaritalStatus*) (has_family_citizen ?*AppHasFamilyCitizen*)(has_family_greencard ?*AppHasFamilyGreencard*)))
)


(defrule citizenInfo
     (applicant{has_family_citizen == 1})
    =>
    (printout t crlf "**************Family member information (Citizen)*****************" crlf crlf)

    (printout t "What is your family member's name?" crlf)

    (bind ?*CitizenName* (read t))

	(printout t "What is your family member's age" crlf)

    (bind ?*CitizenAge* (read t))

	(printout t "What is your family member's relation [for Spouse input 2/ for Parent, input 1/ for sibling 0]" crlf)

    (bind ?*CitizenRelation* (read t))

    (assert (family_citizen (name ?*CitizenName*) (age ?*CitizenAge*) (relation ?*CitizenRelation*))))
    (assert (execution (isComplete 0)))

(defrule greenCardHolderInfo
     (applicant{has_family_greencard == 1})
    =>
     (printout t crlf "**************Family member information (Greencard)*****************" crlf crlf)

    (printout t "What is your family member's name?" crlf)

    (bind ?*CitizenName* (read t))

	(printout t "What is your family member's age" crlf)

    (bind ?*CitizenAge* (read t))

	(printout t "What is your family member's relation [for Spouse input 2/ for Parent input 1/ for sibling 0]" crlf)

    (bind ?*CitizenRelation* (read t))

    (assert (family_greencard (name ?*GreencardHolderName*) (age ?*GreencardHolderAge*) (relation ?*GreencardHolderRelation*))))
    (assert (execution (isComplete 0)))
    
(defrule checkForEmploymentCategory
     (applicant{has_family_greencard == 0})(applicant{has_family_citizen == 0})
    =>
     (printout t crlf "**************Family member information (Greencard)*****************" crlf crlf)

    (printout t "Are you a person of extraordinary ability, an outstanding educators and researchers or an executives with MNC's [1 for yes, 0 for no]" crlf)

    (bind ?*EB1* (read t))

	(printout t "Are you an executive with advanced degrees or a person with exceptional abilities or exceptional professors and researchers.?[1 for yes, 0 for no]" crlf)

    (bind ?*EB2* (read t))

	(printout t "Are you a professional with an advanced degree, involved in activities that will substantially benefit U.S. national interests? [1 for yes, 0 for no]" crlf)

    (bind ?*EB2NationalInterest* (read t))
    
   	(printout t "Are you a professional with a U.S. BachelorÕs degree, skilled and unskilled workers.? [1 for yes, 0 for no]" crlf)

    (bind ?*EB3* (read t))
    
    (printout t "Are you a religious workers or a Special Immigrants [1 for yes, 0 for no]" crlf)

    (bind ?*EB4* (read t))
    
    (printout t "Are you an investor who agrees to invest $1 million or more into a U.S. business that employs at least 10 workers [1 for yes, 0 for no]" crlf)

    (bind ?*EB5* (read t))

    (assert (employment_based (EB1 ?*EB1*) (EB2 ?*EB2*) (EB2 ?*EB2NationalInterest*) (EB3 ?*EB3*)(EB4 ?*EB4*)(EB5 ?*EB5*)))
    (assert (execution (isComplete 0)))
    )


(defrule checkForRefugeeCategory

     (applicant{has_family_greencard == 0})(applicant{has_family_citizen == 0})(employment_based {EB1 == 0} {EB2 == 0} {EB3 == 0} {EB4 == 0} {EB5 ==0}) (diversity{inlist == 0})(cuban {native_citizen == 0} {spouse_or_child == 0})  

    =>

     (printout t crlf "************** Refugee / Asylee (Greencard) *****************" crlf crlf)

    (printout t "Are you a foreigner? 1/0" crlf)

    (bind ?*OutsideCountry* (read t))	

    (printout t "Are you at the border of US? 1/0" crlf)

    (bind ?*AtBorder* (read t))	

    (assert (refugee (outside_country_citizen ?*OutsideCountry*) (is_at_the_border ?*AtBorder*)))

    (assert (execution (isComplete 0)))

)

(defrule checkForDiversityCategory

     (applicant{has_family_greencard == 0})(applicant{has_family_citizen == 0})(employment_based {EB1 == 0} {EB2 == 0} {EB3 == 0} {EB4 == 0} {EB5 ==0}) 

    =>

     (printout t crlf "************** Diversity Lottery (Greencard) *****************" crlf crlf)

    (printout t "Are you from a country that is among the diversity country list by USA? 1/0 " crlf)

    (bind ?*diversity* (read t))	

    (assert (diversity (inlist ?*diversity*)))

    (assert (execution (isComplete 0)))

)


(defrule checkForCubanCategory

     (applicant{has_family_greencard == 0})(applicant{has_family_citizen == 0})(employment_based {EB1 == 0} {EB2 == 0} {EB3 == 0} {EB4 == 0} {EB5 ==0})(diversity{inlist == 0})
    =>
     (printout t crlf "************** Cuban Act (Greencard) *****************" crlf crlf)
    
    (printout t "Are you cuabn native or citizen? 1/0" crlf)
    
    (bind ?*cubanNative* (read t))	
    
    (printout t "Are you a souse or child of a cuban native or citizen? 1/0" crlf)
    
    (bind ?*cubanRelated* (read t))	
    
    (assert (cuban (native_citizen ?*cubanNative*) (spouse_or_child ?*cubanRelated*)))
    
    (assert (execution (isComplete 0)))

)    

(defrule FamilyPriority1
(applicant{marital_status == 0}) (applicant{has_family_citizen == 1})(applicant{age >= 21})(family_citizen {relation == 1})
=> 
 (bind ?*FamilyQualifier* 1)
 (printout t "Type: F" ?*FamilyQualifier*)
        (printout t "Family First Preference is for unmarried adults who are at least 21 years old and have at least one U.S. parent.")

)


(defrule FamilyPriority2
(applicant{marital_status == 1}) (applicant{has_family_greencard == 1}) (family_citizen {relation == 2})
  =>
 	(printout t "Type: F2A")
        (printout t "Family Second Preference is for spouses and unmarried children under 21 years old of Green Card holders with an F2A designation")
)


(defrule FamilyPriority2A
(applicant{marital_status == 0}) (applicant{has_family_greencard == 1}) (family_citizen {relation == 1})(family_citizen {age < 21})
  =>
 	(printout t "Type: F2A" ?*FamilyQualifier*)
    (printout t "Family Second Preference A applies to spouses and unmarried children under 21 years old of Green Card holders with an F2A designation.")

)



(defrule FamilyPriority2B
(applicant{marital_status == 0}) (applicant{has_family_greencard == 1}) (family_greencard {relation == 1})(family_citizen {age >= 21})
  =>
 	(printout t "Type: F" ?*FamilyQualifier*)
    (printout t "
Family Second Preference B applies to Unmarried children of green card holders of age 21 or older and they are given an F2B designation. 
        ")

)



(defrule FamilyPriority3
(applicant{marital_status == 1}) (applicant{has_family_citizen == 1}) (family_citizen {relation == 1})
  =>
    (bind ?*FamilyQualifier* 3)
 	(printout t "Type: F" ?*FamilyQualifier*)
    (printout t "Family Third Preference is applied to married people of any age with at least one parent who is a United States citizen")

)



(defrule FamilyPriority4
(applicant{marital_status == 0}) (applicant{has_family_citizen == 1}) (family_citizen {relation == 0})(family_citizen {age >= 21})
  =>
    (bind ?*FamilyQualifier* 4)
 	(printout t "Type: F" ?*FamilyQualifier*)
    (printout t "Family Fourth Preference is for sisters and brothers of United States citizens, assuming the citizen is at least 21 years old")
)

(defrule EB1Category
(employment_based{EB1 == 1})
=> 
 (printout t "Type: EB1")
        (printout t " Employment First Preference is given to outstanding educators and researchers, executives with multi-national companies, and people with extraordinary abilities in the arts, sciences, athletics or business. "))

(defrule EB2Category
(employment_based{EB2 == 1})
=> 
 (printout t "Type: EB2")
        (printout t " Employment Second Preference is given to executives with advanced degrees, and persons with exceptional abilities or exceptional professors and researchers "))

(defrule EB2NationalInterestCategory
(employment_based{EB2NationalInterest == 1})
=> 
 (printout t "Type: EB2 National Interst")
        (printout t " Employment Second Preference with a National Interest Waiver is given to persons and advanced degree professionals involved in activities that will substantially benefit U.S. national interests. "))

(defrule EB3Category
(employment_based{EB2 == 1})
=> 
 (printout t "Type: EB3")
        (printout t "Employment Third Preference is given to professionals with a U.S. BachelorÕs degree, skilled and unskilled workers.  "))

(defrule EB4Category
(employment_based{EB4 == 1})
=> 
 (printout t "Type: EB4")
        (printout t "Employment Fourth Preference is for religious workers, other miscellaneous categories of workers and those who are defined as ÒSpecial Immigrants.Ó Special immigrants can fall into many categories and situations."))

(defrule EB5Category
(employment_based{EB5 == 1})
=> 
 (printout t "Type: EB5")
    (printout t "Employment Fifth Preference is for investors who agree to invest $1 million or more into a U.S. business that employs at least 10 workers. This amount drops to $500,000 if the investment is made in an area designated as economically depressed."))

(defrule Refugee

(refugee{outside_country_citizen == 1})(refugee{is_at_the_border == 0})

  =>

    (bind ?*FamilyQualifier* Refugee)

 	(printout t "Type: " ?*FamilyQualifier*)
    (printout t "Refugee status is for people outside the boundaries of the United States. Granting asylum applies the same standards as granting refugee status.")
)



(defrule Asylum

(refugee{outside_country_citizen == 1})(refugee{is_at_the_border == 1})

  =>

    (bind ?*FamilyQualifier* Asylee)

    (printout t "Type: " ?*FamilyQualifier*)
    (printout t "Asylum is for people already in the United States or they are at a border, such as an air, land or sea port of entry, ready to cross into the U.S. ")
)



(defrule Diversity

(diversity{inlist == 1})

  =>

    (bind ?*FamilyQualifier* "Diversity Category")

    (printout t "Type: " ?*FamilyQualifier*)
    (printout t " Were selected for a diversity visa in the Department of StateÕs diversity visa lottery " )
      (printout t " Asylum is for people already in the United States or they are at a border, such as an air, land or sea port of entry, ready to cross into the U.S. 
         ")
    )



(defrule CubanNative

(cuban{native_citizen == 1})

  =>

    (bind ?*FamilyQualifier* "Cuban Act Category")

    (printout t "Type: " ?*FamilyQualifier*)
  (printout t " Are a Cuban native or citizen, or Are the spouse or child of a Cuban native or citizen
         ")
)



(defrule CubanRelated

(cuban{spouse_or_child == 1})(cuban{native_citizen == 0})

  =>

    (bind ?*FamilyQualifier* "Cuban Act Category")

    (printout t "Type: " ?*FamilyQualifier*)

)



(deffunction preCheck()

	(bind ?*isValidInp* 1)

    (if(= ?*isValidInp* 1) then

		(assert (inputTaken (inp 1) (isValid ?*isValidInp*)))

    ;(bind ?*FamilyQualifier* (checkFamilyGreenCard))

    ;(printout t crlf crlf "**************Value**************" ?*FamilyQualifier* crlf crlf)   

    

    )

)





(defrule invalidInput

    (inputTaken{inp == 1})(inputTaken{isValid == 0}) (execution {isComplete == 0})

    =>

    (printout t "You have entered an invalid input. Please Enter again" crlf)

    (assert (execution (isComplete 1)))

)





(reset)

(facts)

(run)

(deftemplate inputTaken 

    (slot inp)

    (slot isValid)

)   



(deftemplate execution 

    (slot isComplete)

)



(deftemplate validSkill)


(deftemplate refugee

    (slot outside_country_citizen )

    (slot is_at_the_border))





(deftemplate cuban

    (slot native_citizen )

    (slot spouse_or_child ))





(deftemplate diversity

    (slot inlist)


    )

(defglobal

    ?*AppName* = ""

    ?*AppAge* = 0

    ?*AppMaritalStatus* =  0

    ?*AppHasFamilyCitizen* = 0

    ?*AppHasFamilyGreencard* = 0

    ?*CitizenName* = ""

    ?*CitizenAge* = 0

    ?*CitizenRelation* = 0

    ?*GreencardHolderName* = ""

    ?*GreencardHolderAge* = 0

    ?*GreencardHolderRelation* = 0

    ?*inpTaken* = 0  

    ?*isValidInp* = ""

    ?*isExecuted* = 0 

    ?*FamilyQualifier* = ""
    
    ?*EB1* = 0 
    
    ?*EB2* = 0 
    
    ?*EB2NationalInterest* = 0 
    
    ?*EB3* = 0 
    
    ?*EB4* = 0 
    
    ?*EB5* = 0 
    

    ?*OutsideCountry* = 0

    ?*AtBorder* = 0

    ?*diversity*  = 0

    ?*cubnaNative*  = 0

    ?*cubanRelated*  = 0

    )

(defrule checkForFamilyCategory

    =>

    (printout t crlf crlf "****WELCOME TO THE GREEN CARD DECISION MAKER BOT****" crlf)

    (printout t "$$ This application uses the user applicant's information to decide what kind of a visa he will get and is rejected if he doesn't qualify for that visa" crlf)

    (printout t "**NOTE: PLEASE PROVIDE A VALID INPUT FOR ALL THE QUESTIONS. REFER THE DOCUMENTATION FOR MORE INFO ON HOW TO USE THIS APPLICATION" crlf)

    (printout t "**************Applicant Info Section*****************" crlf crlf)        

    (printout t "Please enter your name: " crlf)

    (bind ?*AppName* (read t))

    (printout t "What is your age?" crlf)

    (bind ?*AppAge* (read t))

    (printout t "Are you married?[for yes, input 1/ for no, input 0]" crlf)

    (bind ?*AppMaritalStatus* (read t))

    (printout t "Do you have a US Citizen in your immediate family?[for yes, input 1/ for no, input 0]" crlf)

    (bind ?*AppHasFamilyCitizen* (read t))

    (printout t "Do you have a green card holder in your immediate family?[for yes, input 1/ for no, input 0]" crlf)

    (bind ?*AppHasFamilyGreencard* (read t))

    (assert (applicant (name ?*AppName*) (age ?*AppAge*) (marital_status ?*AppMaritalStatus*) (has_family_citizen ?*AppHasFamilyCitizen*)(has_family_greencard ?*AppHasFamilyGreencard*)))
)


(defrule citizenInfo
     (applicant{has_family_citizen == 1})
    =>
    (printout t crlf "**************Family member information (Citizen)*****************" crlf crlf)

    (printout t "What is your family member's name?" crlf)

    (bind ?*CitizenName* (read t))

	(printout t "What is your family member's age" crlf)

    (bind ?*CitizenAge* (read t))

	(printout t "What is your family member's relation [for Spouse input 2/ for Parent, input 1/ for sibling 0]" crlf)

    (bind ?*CitizenRelation* (read t))

    (assert (family_citizen (name ?*CitizenName*) (age ?*CitizenAge*) (relation ?*CitizenRelation*))))
    (assert (execution (isComplete 0)))

(defrule greenCardHolderInfo
     (applicant{has_family_greencard == 1})
    =>
     (printout t crlf "**************Family member information (Greencard)*****************" crlf crlf)

    (printout t "What is your family member's name?" crlf)

    (bind ?*CitizenName* (read t))

	(printout t "What is your family member's age" crlf)

    (bind ?*CitizenAge* (read t))

	(printout t "What is your family member's relation [for Spouse input 2/ for Parent input 1/ for sibling 0]" crlf)

    (bind ?*CitizenRelation* (read t))

    (assert (family_greencard (name ?*GreencardHolderName*) (age ?*GreencardHolderAge*) (relation ?*GreencardHolderRelation*))))
    (assert (execution (isComplete 0)))
    
(defrule checkForEmploymentCategory
     (applicant{has_family_greencard == 0})(applicant{has_family_citizen == 0})
    =>
     (printout t crlf "**************Family member information (Greencard)*****************" crlf crlf)

    (printout t "Are you a person of extraordinary ability, an outstanding educators and researchers or an executives with MNC's [1 for yes, 0 for no]" crlf)

    (bind ?*EB1* (read t))

	(printout t "Are you an executive with advanced degrees or a person with exceptional abilities or exceptional professors and researchers.?[1 for yes, 0 for no]" crlf)

    (bind ?*EB2* (read t))

	(printout t "Are you a professional with an advanced degree, involved in activities that will substantially benefit U.S. national interests? [1 for yes, 0 for no]" crlf)

    (bind ?*EB2NationalInterest* (read t))
    
   	(printout t "Are you a professional with a U.S. BachelorÕs degree, skilled and unskilled workers.? [1 for yes, 0 for no]" crlf)

    (bind ?*EB3* (read t))
    
    (printout t "Are you a religious workers or a Special Immigrants [1 for yes, 0 for no]" crlf)

    (bind ?*EB4* (read t))
    
    (printout t "Are you an investor who agrees to invest $1 million or more into a U.S. business that employs at least 10 workers [1 for yes, 0 for no]" crlf)

    (bind ?*EB5* (read t))

    (assert (employment_based (EB1 ?*EB1*) (EB2 ?*EB2*) (EB2 ?*EB2NationalInterest*) (EB3 ?*EB3*)(EB4 ?*EB4*)(EB5 ?*EB5*)))
    (assert (execution (isComplete 0)))
    )


(defrule checkForRefugeeCategory

     (applicant{has_family_greencard == 0})(applicant{has_family_citizen == 0})(employment_based {EB1 == 0} {EB2 == 0} {EB3 == 0} {EB4 == 0} {EB5 ==0}) (diversity{inlist == 0})(cuban {native_citizen == 0} {spouse_or_child == 0})  

    =>

     (printout t crlf "************** Refugee / Asylee (Greencard) *****************" crlf crlf)

    (printout t "Are you a foreigner? 1/0" crlf)

    (bind ?*OutsideCountry* (read t))	

    (printout t "Are you at the border of US? 1/0" crlf)

    (bind ?*AtBorder* (read t))	

    (assert (refugee (outside_country_citizen ?*OutsideCountry*) (is_at_the_border ?*AtBorder*)))

    (assert (execution (isComplete 0)))

)

(defrule checkForDiversityCategory

     (applicant{has_family_greencard == 0})(applicant{has_family_citizen == 0})(employment_based {EB1 == 0} {EB2 == 0} {EB3 == 0} {EB4 == 0} {EB5 ==0}) 

    =>

     (printout t crlf "************** Diversity Lottery (Greencard) *****************" crlf crlf)

    (printout t "Are you from a country that is among the diversity country list by USA? 1/0 " crlf)

    (bind ?*diversity* (read t))	

    (assert (diversity (inlist ?*diversity*)))

    (assert (execution (isComplete 0)))

)


(defrule checkForCubanCategory

     (applicant{has_family_greencard == 0})(applicant{has_family_citizen == 0})(employment_based {EB1 == 0} {EB2 == 0} {EB3 == 0} {EB4 == 0} {EB5 ==0})(diversity{inlist == 0})
    =>
     (printout t crlf "************** Cuban Act (Greencard) *****************" crlf crlf)
    
    (printout t "Are you cuabn native or citizen? 1/0" crlf)
    
    (bind ?*cubanNative* (read t))	
    
    (printout t "Are you a souse or child of a cuban native or citizen? 1/0" crlf)
    
    (bind ?*cubanRelated* (read t))	
    
    (assert (cuban (native_citizen ?*cubanNative*) (spouse_or_child ?*cubanRelated*)))
    
    (assert (execution (isComplete 0)))

)    

(defrule FamilyPriority1
(applicant{marital_status == 0}) (applicant{has_family_citizen == 1})(applicant{age >= 21})(family_citizen {relation == 1})
=> 
 (bind ?*FamilyQualifier* 1)
 (printout t "Type: F" ?*FamilyQualifier*)
        (printout t "Family First Preference is for unmarried adults who are at least 21 years old and have at least one U.S. parent.")

)


(defrule FamilyPriority2
(applicant{marital_status == 1}) (applicant{has_family_greencard == 1}) (family_citizen {relation == 2})
  =>
 	(printout t "Type: F2A")
        (printout t "Family Second Preference is for spouses and unmarried children under 21 years old of Green Card holders with an F2A designation")
)


(defrule FamilyPriority2A
(applicant{marital_status == 0}) (applicant{has_family_greencard == 1}) (family_citizen {relation == 1})(family_citizen {age < 21})
  =>
 	(printout t "Type: F2A" ?*FamilyQualifier*)
    (printout t "Family Second Preference A applies to spouses and unmarried children under 21 years old of Green Card holders with an F2A designation.")

)



(defrule FamilyPriority2B
(applicant{marital_status == 0}) (applicant{has_family_greencard == 1}) (family_greencard {relation == 1})(family_citizen {age >= 21})
  =>
 	(printout t "Type: F" ?*FamilyQualifier*)
    (printout t "
Family Second Preference B applies to Unmarried children of green card holders of age 21 or older and they are given an F2B designation. 
        ")

)



(defrule FamilyPriority3
(applicant{marital_status == 1}) (applicant{has_family_citizen == 1}) (family_citizen {relation == 1})
  =>
    (bind ?*FamilyQualifier* 3)
 	(printout t "Type: F" ?*FamilyQualifier*)
    (printout t "Family Third Preference is applied to married people of any age with at least one parent who is a United States citizen")

)



(defrule FamilyPriority4
(applicant{marital_status == 0}) (applicant{has_family_citizen == 1}) (family_citizen {relation == 0})(family_citizen {age >= 21})
  =>
    (bind ?*FamilyQualifier* 4)
 	(printout t "Type: F" ?*FamilyQualifier*)
    (printout t "Family Fourth Preference is for sisters and brothers of United States citizens, assuming the citizen is at least 21 years old")
)

(defrule EB1Category
(employment_based{EB1 == 1})
=> 
 (printout t "Type: EB1")
        (printout t " Employment First Preference is given to outstanding educators and researchers, executives with multi-national companies, and people with extraordinary abilities in the arts, sciences, athletics or business. "))

(defrule EB2Category
(employment_based{EB2 == 1})
=> 
 (printout t "Type: EB2")
        (printout t " Employment Second Preference is given to executives with advanced degrees, and persons with exceptional abilities or exceptional professors and researchers "))

(defrule EB2NationalInterestCategory
(employment_based{EB2NationalInterest == 1})
=> 
 (printout t "Type: EB2 National Interst")
        (printout t " Employment Second Preference with a National Interest Waiver is given to persons and advanced degree professionals involved in activities that will substantially benefit U.S. national interests. "))

(defrule EB3Category
(employment_based{EB2 == 1})
=> 
 (printout t "Type: EB3")
        (printout t "Employment Third Preference is given to professionals with a U.S. BachelorÕs degree, skilled and unskilled workers.  "))

(defrule EB4Category
(employment_based{EB4 == 1})
=> 
 (printout t "Type: EB4")
        (printout t "Employment Fourth Preference is for religious workers, other miscellaneous categories of workers and those who are defined as ÒSpecial Immigrants.Ó Special immigrants can fall into many categories and situations."))

(defrule EB5Category
(employment_based{EB5 == 1})
=> 
 (printout t "Type: EB5")
    (printout t "Employment Fifth Preference is for investors who agree to invest $1 million or more into a U.S. business that employs at least 10 workers. This amount drops to $500,000 if the investment is made in an area designated as economically depressed."))

(defrule Refugee

(refugee{outside_country_citizen == 1})(refugee{is_at_the_border == 0})

  =>

    (bind ?*FamilyQualifier* Refugee)

 	(printout t "Type: " ?*FamilyQualifier*)
    (printout t "Refugee status is for people outside the boundaries of the United States. Granting asylum applies the same standards as granting refugee status.")
)



(defrule Asylum

(refugee{outside_country_citizen == 1})(refugee{is_at_the_border == 1})

  =>

    (bind ?*FamilyQualifier* Asylee)

    (printout t "Type: " ?*FamilyQualifier*)
    (printout t "Asylum is for people already in the United States or they are at a border, such as an air, land or sea port of entry, ready to cross into the U.S. ")
)



(defrule Diversity

(diversity{inlist == 1})

  =>

    (bind ?*FamilyQualifier* "Diversity Category")

    (printout t "Type: " ?*FamilyQualifier*)
    (printout t " Were selected for a diversity visa in the Department of StateÕs diversity visa lottery " )
      (printout t " Asylum is for people already in the United States or they are at a border, such as an air, land or sea port of entry, ready to cross into the U.S. 
         ")
    )



(defrule CubanNative

(cuban{native_citizen == 1})

  =>

    (bind ?*FamilyQualifier* "Cuban Act Category")

    (printout t "Type: " ?*FamilyQualifier*)
  (printout t " Are a Cuban native or citizen, or Are the spouse or child of a Cuban native or citizen
         ")
)



(defrule CubanRelated

(cuban{spouse_or_child == 1})(cuban{native_citizen == 0})

  =>

    (bind ?*FamilyQualifier* "Cuban Act Category")

    (printout t "Type: " ?*FamilyQualifier*)

)



(deffunction preCheck()

	(bind ?*isValidInp* 1)

    (if(= ?*isValidInp* 1) then

		(assert (inputTaken (inp 1) (isValid ?*isValidInp*)))

    ;(bind ?*FamilyQualifier* (checkFamilyGreenCard))

    ;(printout t crlf crlf "**************Value**************" ?*FamilyQualifier* crlf crlf)   

    

    )

)





(defrule invalidInput

    (inputTaken{inp == 1})(inputTaken{isValid == 0}) (execution {isComplete == 0})

    =>

    (printout t "You have entered an invalid input. Please Enter again" crlf)

    (assert (execution (isComplete 1)))

)





(reset)

(facts)

(run)