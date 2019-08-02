* Encoding: windows-1252.
 /*  SPSS Data Definition File
 /*  Created by ddltox on May 17, 2019  (Fri 01:32 PM Eastern Daylight Time)
 /*  DDL source file: "alldata.ddl".

TITLE "NICHE: Geriatric Institutional Assessment Profile".
COMMENT  DDL indicates that dataset record length (reclen) is 2684 columns.
COMMENT  DDL indicates that there are 1300 cases (ncases) in the dataset.

DATA LIST fixed records=1
  FILE="L:\survey\NICHE\Cohort 4\data export\2019-05-17\alldata.dat"  /* Replace 'x' with full path name of your input data file.
 /1           CASEID 1-5            complete 186   startDate 187-206 (A)
  finishDate 207-226 (A)       fname 227-276 (A)       lname 277-326 (A)
 primaryNursingUnit 327-374 (A)        role 375-414 (A)      tenure 415-424 (A)
       email 425-524 (A)   workSched 525-584 (A) rotatingSched 585-604 (A)
           batch 605-607      facilityID 608-610 facilityName 611-680 (A)
        included 687 (A)       adminPlan 688 (A)               consent 6
                  Q1 7-8               Q1_spec 9                Q4 10-11
                 Q7_1 12                 Q7_2 13                 Q7_3 14
                 Q7_4 15                 Q7_5 16                 Q7_7 17
                 Q7_8 18                 Q7_9 19                Q7_10 20
                Q7_11 21                Q7_12 22                Q7_13 23
                Q7_14 24                Q7_15 25                Q7_16 26
                Q7_17 27                Q7_18 28                Q7_19 29
                Q7_20 30                Q7_21 31                Q7_23 32
                Q7_24 33                Q7_26 34                Q7_27 35
                Q7_28 36                Q7_29 37                Q7_30 38
                 Q8_1 39                 Q8_2 40                 Q8_3 41
                 Q8_5 42                 Q8_6 43                 Q8_7 44
                Q8_10 45                Q8_11 46                Q8_12 47
                  Q10 48                  Q11 49                  Q12 50
                  Q13 51                  Q14 52                  Q15 53
                  Q17 54                  Q18 55                Q41_1 56
                Q41_2 57                Q41_3 58                Q41_4 59
                Q41_5 60                Q41_6 61                Q41_7 62
                Q41_8 63                Q41_9 64               Q41_10 65
                 Q42a 66                 Q42b 67                 Q42c 68
                 Q42d 69                 Q43a 70                 Q43b 71
                 Q43c 72                 Q43d 73                 Q44a 74
                 Q44b 75                 Q44c 76                 Q44d 77
                 Q45a 78                 Q45b 79                 Q45c 80
                 Q45d 81                 Q46a 82                 Q46b 83
                 Q46c 84                 Q46d 85                 Q47a 86
                 Q47b 87                 Q47c 88                 Q47d 89
                 Q48a 90                 Q48b 91                 Q48c 92
                 Q48d 93                 Q49a 94                 Q49b 95
                 Q49c 96                 Q49d 97                 Q50a 98
                 Q50b 99                Q50c 100                Q50d 101
                Q51a 102                Q51b 103                Q51c 104
                Q51d 105                Q52a 106                Q52b 107
                Q52c 108                Q52d 109                Q53a 110
                Q53b 111                Q53c 112                Q53d 113
                Q54a 114                Q54b 115                Q54c 116
                Q54d 117                Q55a 118                Q55b 119
                Q55c 120                Q55d 121                Q56a 122
                Q56b 123                Q56c 124                Q56d 125
                Q57a 126                Q57b 127                Q57c 128
                Q57d 129                Q58a 130                Q58b 131
                Q58c 132                Q58d 133                Q59a 134
                Q59b 135                Q59c 136                Q59d 137
                Q60a 138                Q60b 139                Q60c 140
                Q60d 141                Q61a 142                Q61b 143
                Q61c 144                Q61d 145                 Q21 146
                 Q22 147               Q23_1 148               Q23_2 149
               Q23_3 150               Q23_4 151               Q23_5 152
               Q23_6 153            Q23_spec 154              Q2 155-156
              Q3 157-158                 Q40 159                 Q24 160
                 Q25 161                 Q26 162                 Q27 163
                 Q28 164                 Q29 165            Q29_spec 166
                 Q30 167                 Q31 168                 Q32 169
             Q33 170-171             Q34 172-173             Q34_DNC 174
                 Q35 175            Q35_spec 176                 Q36 177
             Q37 178-179             Q38 180-181              Q39_SW 182
        Q39_ICUS 183-184            Q39_OCUS 185
   .

VARIABLE LABELS
   CASEID    'Case identification number (assigned by SRI)' /
   complete  'Survey Status' /
   startDate 'Start Date' /
   finishDate 'Finish Date' /
   fname     'First Name (provided by PI)' /
   lname     'Last Name (provided by PI)' /
   primaryNursingUnit 'Primary Nursing Unit (provided by PI)' /
   role      'Role (provided by PI)' /
   tenure    'Tenure (provided by PI)' /
   email     'Email (provided by PI)' /
   workSched 'Work Schedule (provided by PI)' /
   rotatingSched 'Rotating Schedule (provided by PI)' /
   batch     'Batch (provided by PI)' /
   facilityID 'Facility ID (provided by PI)' /
   facilityName 'Facility name (provided by PI)' /
   included  'Included (Provided by PI)' /
   adminPlan 'Admin plan (Provided by PI)' /
   consent   'Consent' /
   Q1        'Position' /
   Q1_spec   'Specify other position' /
   Q4        'Prime unit' /
   Q7_1      'Staff provide individualized care' /
   Q7_2      'Older adults get the care they need' /
   Q7_3      'Evidence-based clinical practices used' /
   Q7_4      'Older adult patient issues addressed' /
   Q7_5      'Staff know how aging affects treatment' /
   Q7_7      'Aging considered when planning-evaluating care' /
   Q7_8      'Patients receive information they need' /
   Q7_9      'Families receive information they need' /
   Q7_10     'Families receive support they' /
   Q7_11     'Staff informed on patient pre-hospitalization baseline' /
   Q7_12     'Continuity of care across hospital units' /
   Q7_13     'Continuity of care across settings' /
   Q7_14     'Adequate time for physical needs of older adults' /
   Q7_15     'Adequate time for psycho-social needs of older adults' /
   Q7_16     'Adequate time for medication management' /
   Q7_17     'Colleagues value my opinion about proper care of older adult patients' /
   Q7_18     'Older adult clinical conditions used for admission decisions' /
   Q7_19     'Clinicians-administrators work together' /
   Q7_20     'Disagreeing with supervisor is acceptable regarding caret' /
   Q7_21     'Staff have input determining policy' /
   Q7_23     'Staff know how to communicate with older adults with dementia' /
   Q7_24     'Staff are expected to educate family caregivers' /
   Q7_26     'Time required for common nursing problems is anticipated' /
   Q7_27     'Training readily  available for staff' /
   Q7_28     'Staff can take time to implement new care practices' /
   Q7_29     'Nurse admins interested in improving care for older adults' /
   Q7_30     'Care of the older adult is a priority on my unit' /
   Q8_1      'Lack of knowledge about care - Barrier' /
   Q8_2      'Inadequate written policies - Barrier' /
   Q8_3      'Differences of opinion - Barrier' /
   Q8_5      'Lack of specialized equipment - Barrier' /
   Q8_6      'Exclusion of nurses from care decisions - Barrier' /
   Q8_7      'Exclusion of competent older adults from care decisions - Barrier' /
   Q8_10     'Staff shortage - Barrier' /
   Q8_11     'Communication difficulties with older adults-families - Barrier' /
   Q8_12     'Confusion over who has authority over older adult - Barrier' /
   Q10       'Proportion of time older adults' /
   Q11       'Difficulty' /
   Q12       'Reward' /
   Q13       'Number gerontological nurse specialists' /
   Q14       'Number geriatric physicians' /
   Q15       'Use of geriatric consultative services' /
   Q17       'QUALEDUOD' /
   Q18       'KNOWLEDGEOA' /
   Q41_1     'As people grow older, their intelligence declines significantly.' /
   Q41_2     'Personality changes with age.' /
   Q41_3     'Memory loss is a normal part of aging.' /
   Q41_4     'Clinical depression occurs more frequently in older adults than younger people.' /
   Q41_5     'Older adults have more trouble sleeping than younger adults do.' /
   Q41_6     'Bladder capacity decreases with age, which leads to frequent urination.' /
   Q41_7     'Increased problem with constipation represents a normal change as people get older.' /
   Q41_8     'Older people are much happier if they are allowed to disengage from society.' /
   Q41_9     'Abuse of older adults is not a significant problem.' /
   Q41_10    'Older persons take longer to recover from physical and psychological stress.' /
   Q42a      'Rubber-soled footwear such as sneakers' /
   Q42b      'Exacerbation of a condition such as heart failure' /
   Q42c      'Utilizing prescribed glasses and hearing aids' /
   Q42d      'Participating in daily exercise programs' /
   Q43a      'Provide Mrs. Q with a floor length robe when out of bed.' /
   Q43b      'Encourage Mrs. Q to wear cotton socks to bed.' /
   Q43c      'Place Mrs. Q''s glasses on her overbed table within her reach.' /
   Q43d      'Remind Mrs. Q to be careful not to fall.' /
   Q44a      'Look for changes in skin color when applying pressure to the skin.' /
   Q44b      'Determine if the person is experiencing pain over a bony prominence.' /
   Q44c      'Examine for edema in the suspected area.' /
   Q44d      'Observe for non-blanching erythema.' /
   Q45a      'Ensure adequate caloric intake.' /
   Q45b      'Use a pressure relieving mattress.' /
   Q45c      'Raise the head of the bed at least 45 degrees.' /
   Q45d      'Turn or reposition Mrs. D every two hours when seated in a chair.' /
   Q46a      'Drug interaction or overmedication' /
   Q46b      'Surgical site infection' /
   Q46c      'Vertebral compression fracture' /
   Q46d      'Dehydration' /
   Q47a      'Evaluate Mr. S''s mentation by asking him to repeat the months of the year backwards.' /
   Q47b      'Ask Mr. S. if he would like something to eat.' /
   Q47c      'Discontinue Mr. S''s pain medication.' /
   Q47d      'Determine if Mr. S has signs and symptoms of a urinary tract infection.' /
   Q48a      'It is a normal part of aging.' /
   Q48b      'People experiencing urinary incontinence should limit their fluid intake.' /
   Q48c      'Urinary catheters should be used to manage new onset of incontinence in the hospital.' /
   Q48d      'Constipation can contribute to incontinence.' /
   Q49a      'Decreased ability to mobilize' /
   Q49b      'Memory loss' /
   Q49c      'Decreased bladder capacity' /
   Q49d      'Depression' /
   Q50a      'Provide Mr. X with meals in bed to conserve energy.' /
   Q50b      'Use hand-over-hand to support Mr. X to feed himself.' /
   Q50c      'Provide television during meals to ensure a stimulating dining environment.' /
   Q50d      'Recommend an appetite stimulant to the physician.' /
   Q51a      'Braden Scale' /
   Q51b      'Katz Index of Activities of Daily Living' /
   Q51c      'Lawton Instrumental Activities of Daily Living Scale' /
   Q51d      'Min-Mental Status Examination' /
   Q52a      'Increase physical activity during the day.' /
   Q52b      'Offer coffee and other caffeinated beverages throughout the day.' /
   Q52c      'Give sleep medication at night.' /
   Q52d      'Reduce nighttime noise and other stimuli.' /
   Q53a      'Quetiapine (Seroquel, atypical antipsychotic)' /
   Q53b      'Haloperidol (Haldol, typical antipsychotic)' /
   Q53c      'Citalopram (Celexa, SSRI antidepressant)' /
   Q53d      'Lorazepam (Ativan, anxiolytic)' /
   Q54a      'Administer the MS Contin early.' /
   Q54b      'Have Mrs. H get out of bed to the chair.' /
   Q54c      'Employ non-pharmacologic methods of pain control such as a backrub.' /
   Q54d      'Kindly explain to Mrs. H that the next dose of medication is not due until 9:00 pm.' /
   Q55a      'Ask the direct care staff and family to provide their observations regarding pain.' /
   Q55b      'Ask the person to rate the pain, older adults with dementia commonly overestimate pain.' /
   Q55c      'Use both pain scale-nursing judgement to determine their actual pain level.' /
   Q55d      'Use the Pain Assessment in Advanced Dementia (PAINAD) Scale rather than self-report.' /
   Q56a      'Ambien' /
   Q56b      'Benadryl' /
   Q56c      'Halcion' /
   Q56d      'Nidularium' /
   Q57a      'Medications to be avoided in individuals with chronic kidney disease' /
   Q57b      'Potentially inappropriate medications to be avoided in older adults' /
   Q57c      'Potentially inappropriate medications to be avoided in individuals with dementia' /
   Q57d      'Potentially inappropriate medications to be avoided in individuals with Parkinson''s disease' /
   Q58a      'Polypharmacy' /
   Q58b      'Hypertension' /
   Q58c      'Failure to thrive' /
   Q58d      'Poverty' /
   Q59a      'Independently feeds self' /
   Q59b      'Laxative use' /
   Q59c      'Constipation' /
   Q59d      'Normal body weight' /
   Q60a      'AUDIT screening' /
   Q60b      'CAGE questionnaire' /
   Q60c      'Geriatric Depression Scale' /
   Q60d      'Paten Health Questionnaire' /
   Q61a      'I feel like I have accomplished something today.' /
   Q61b      'I am too tired to do anything.' /
   Q61c      'I would like to visit my daughter and her family.' /
   Q61d      'My life has had many ups and downs.' /
   Q21       'Gender' /
   Q22       'Ethnicity' /
   Q23_1     'American Indian or Alaskan Native' /
   Q23_2     'Asian' /
   Q23_3     'Black or African American' /
   Q23_4     'Native Hawaiian or Pacific Islander' /
   Q23_5     'White' /
   Q23_6     'Other race-ethnicity' /
   Q23_spec  'Specify other race-ethnicity' /
   Q2        'Years of experience in profession' /
   Q3        'Years working for employer' /
   Q40       'Completed NICHE GRN program' /
   Q24       'ENGLISHFIRSTLANG' /
   Q25       'Education program' /
   Q26       'NATLCERT' /
   Q27       'NATLCERTGERO' /
   Q28       'RNDOMEST' /
   Q29       'HOSPTIALTYPE' /
   Q29_spec  'Specify other HOSPTIALTYPE' /
   Q30       'RNDEGREE' /
   Q31       'HIGHESTDEGREE' /
   Q32       'JOBSATSF' /
   Q33       'WORKHRS' /
   Q34       'ASSGNTNUMB' /
   Q34_DNC   'Do not care for patients or clients' /
   Q35       'Typical work shift length' /
   Q35_spec  'Specify other work shift length' /
   Q36       'Typical work schedule' /
   Q37       'Hours mandatory overtime per week' /
   Q38       'Hours voluntary overtime per week' /
   Q39_SW    'Residence inside or outside continental US' /
   Q39_ICUS  'Residence inside United States' /
   Q39_OCUS  'Residence outside United States' /
   .

VALUE LABELS
   complete  0 'Partially complete' 1 'Complete' /
   facilityID 1 'Baptist Medical Center Jacksonville' 
             2 'Beaumont Hospital - Troy' 3 'Duke University Hospital' 
             4 'Highland Hospital' 5 'Humber River Hospital' 
             6 'Jersey City Medical Center' 7 'Kent Hospital' 
             8 'LeHigh Valley Hospital' 9 'Phelps Health' 
             10 'Salem Medical Center' 11 'Sanford USD Medical Center' 
             12 'Torrance Memorial Medical Center' 
             13 'University of Maryland Capital Region Health Prince Georges' 
             14 'Banner University Medical Center' 15 'Coney Island Hospital' 
             16 'Danbury Hospital' 17 'Dixie Regional Medical Center' 
             18 'St. Barnabas Hospital' /
   consent   0 'No' 1 'Yes' /
   Q1        1 'Nursing assistant/Aide' 2 'Staff Nurse' 
             3 'Unit Nurse Manager' 
             4 'Clinical Specialist/Nurse Practitioner/Clinical Nurse Leader' 
             5 'Patient Educator' 6 'Staff/Nurse Educator' 7 'Administrator' 
             8 'Staff/Attending MD' 9 'Hospitalist' 
             10 'House Officer/Resident/Fellow' 11 'Pharmacist' 
             12 'Social Worker' 13 'Occupational Therapist' 
             14 'Physical Therapist' 15 'Respiratory Therapist' 
             16 'Lab Technician' 17 'Dietitian' 
             18 'Intravenous (IV) Team member' 19 'Transport Team member' 
             20 'Other' 99 'Refused/Not Answered' /
   Q1_spec   1 'Provided Answer' 9 'Refused/Not Answered' /
   Q4        1 'Emergency Department' 
             2 'Perioperative/Operating Room/Post Anesthesia Care Unit' 
             3 'ICU-Critical Care' 4 'ICU-Coronary Care' 5 'Step-Down Unit' 
             6 'General Medical' 7 'General Surgical' 
             8 'General Medical and Surgical' 
             9 'Non-critical care specialty unit (pulmonary, oncology, ortho' 
             10 'Geriatric Unit/ACE Unit' 11 'Long Term Care Unit' 
             12 'Hospice' 13 'Ambulatory Care' 14 'Rehabilitation' 
             15 'Home Care' 16 'Psychiatric Unit' 17 'Gynecology' 
             18 'Rotating/Float Pool' 99 'Refused/Not Answered' /
   Q7_1      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_2      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_3      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_4      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_5      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_7      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_8      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_9      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_10     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_11     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_12     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_13     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_14     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_15     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_16     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_17     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_18     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_19     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_20     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_21     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_23     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_24     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_26     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_27     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_28     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_29     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q7_30     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_1      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_2      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_3      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_5      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_6      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_7      1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_10     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_11     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q8_12     1 'Strongly disagree' 2 'Disagree' 
             3 'Neither agree nor disagree' 4 'Agree' 5 'Strongly agree' 
             9 'Refused/Not Answered' /
   Q10       1 'Almost all' 2 'More than half' 3 'Half' 4 'Less than half' 
             5 'Almost none' 9 'Refused/Not Answered' /
   Q11       1 'Great difficulty' 2 'Some difficulty' 3 'Neutral' 
             4 'No difficulty' 9 'Refused/Not Answered' /
   Q12       1 'Very rewarding' 2 'Somewhat rewarding' 3 'Neutral' 
             4 'Not rewarding' 9 'Refused/Not Answered' /
   Q13       0 'none' 1 '1' 2 '2' 3 '3' 4 '4' 5 '5 or more' 8 'I do not know' 
             9 'Refused/Not Answered' /
   Q14       0 'none' 1 '1' 2 '2' 3 '3' 4 '4' 5 '5 or more' 8 'I do not know' 
             9 'Refused/Not Answered' /
   Q15       1 'Daily' 2 'Weekly' 3 'Monthly' 4 'Less than monthly' 
             5 'Hardly ever' 6 'Never' 
             7 'There are no geriatric specialists at my institution' 
             9 'Refused/Not Answered' /
   Q17       1 'Poor' 2 'Fair' 3 'Good' 4 'Very Good' 5 'Excellent' 
             9 'Refused/Not Answered' /
   Q18       1 'Extremely knowledgeable' 2 'Moderately knowledgeable' 
             3 'Somewhat knowledgeable' 4 'Slightly knowledgeable' 
             5 'Not at all knowledgeable' 9 'Refused/Not Answered' /
   Q41_1     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_2     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_3     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_4     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_5     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_6     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_7     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_8     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_9     0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q41_10    0 'False' 1 'True' 9 'Refused/Not Answered' /
   Q42a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q42b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q42c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q42d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q43a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q43b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q43c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q43d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q44a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q44b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q44c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q44d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q45a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q45b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q45c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q45d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q46a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q46b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q46c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q46d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q47a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q47b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q47c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q47d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q48a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q48b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q48c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q48d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q49a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q49b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q49c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q49d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q50a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q50b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q50c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q50d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q51a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q51b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q51c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q51d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q52a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q52b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q52c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q52d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q53a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q53b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q53c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q53d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q54a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q54b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q54c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q54d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q55a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q55b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q55c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q55d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q56a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q56b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q56c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q56d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q57a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q57b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q57c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q57d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q58a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q58b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q58c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q58d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q59a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q59b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q59c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q59d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q60a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q60b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q60c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q60d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q61a      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q61b      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q61c      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q61d      0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q21       1 'Male' 2 'Female' 3 'Prefer not to report' 
             9 'Refused/Not Answered' /
   Q22       1 'Hispanic or Latino/Latina' 2 'Not Hispanic or Latino/Latina' 
             9 'Refused/Not Answered' /
   Q23_1     0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q23_2     0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q23_3     0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q23_4     0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q23_5     0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q23_6     0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q23_spec  1 'Provided Answer' 9 'Refused/Not Answered' /
   Q2        99 'Refused/Not Answered' /
   Q3        99 'Refused/Not Answered' /
   Q40       1 'Yes' 2 'No' 9 'Refused/Not Answered' /
   Q24       1 'Yes' 2 'No' 9 'Refused/Not Answered' /
   Q25       1 'Yes, full-time' 2 'Yes, part-time' 3 'No' 
             9 'Refused/Not Answered' /
   Q26       1 'Yes' 2 'No' 9 'Refused/Not Answered' /
   Q27       1 'Yes' 2 'No' 9 'Refused/Not Answered' /
   Q28       1 'Yes' 2 'No' 9 'Refused/Not Answered' /
   Q29       1 'Academic medical center' 2 'Community teaching hospital' 
             3 'Non-teaching hospital' 4 'Other' 9 'Refused/Not Answered' /
   Q29_spec  1 'Provided Answer' 9 'Refused/Not Answered' /
   Q30       1 'Diploma' 2 'Associate''s Degree' 3 'Baccalaureate Degree' 
             4 'Master''s Degree' 5 'Doctorate' 
             6 'I am not a registered nurse' 9 'Refused/Not Answered' /
   Q31       1 'High School Diploma or GED' 2 'Vocational Training (LPN/LVN)' 
             3 'BS, BA' 4 'MS, MA' 
             5 'Clinical Doctorate: ND, DNP, PharmD, DPT, DSW' 
             6 'Research Doctorate: PhD, EdD, SciD, DNSc.' 
             7 'Other professional degree: MD, JD, MBA, MPH, MPA, MSW' 
             9 'Refused/Not Answered' /
   Q32       1 'Strongly agree' 2 'Agree' 3 'Neither agree nor disagree' 
             4 'Disagree' 5 'Strongly disagree' 9 'Refused/Not Answered' /
   Q33       99 'Refused/Not Answered' /
   Q34       99 'Refused/Not Answered' /
   Q34_DNC   0 'No' 1 'Yes' 9 'Refused/Not Answered' /
   Q35       1 '8-hour shifts' 2 '10-hour shifts' 3 '12-hour shifts' 
             4 'Flexible Schedule' 5 'Other' 9 'Refused/Not Answered' /
   Q35_spec  1 'Provided Answer' 9 'Refused/Not Answered' /
   Q36       1 'Day' 2 'Evening' 3 'Night' 4 'Rotating Schedule' 
             9 'Refused/Not Answered' /
   Q37       99 'Refused/Not Answered' /
   Q38       99 'Refused/Not Answered' /
   Q39_SW    1 'In the United States' 2 'Outside the United States' 
             9 'Refused/Not Answered' /
   Q39_ICUS  1 'Alabama' 2 'Alaska' 3 'Arizona' 4 'Arkansas' 5 'California' 
             6 'Colorado' 7 'Connecticut' 8 'Delaware' 9 'Florida' 
             10 'Georgia' 11 'Hawaii' 12 'Idaho' 13 'Illinois' 14 'Indiana' 
             15 'Iowa' 16 'Kansas' 17 'Kentucky' 18 'Louisiana' 19 'Maine' 
             20 'Maryland' 21 'Massachusetts' 22 'Michigan' 23 'Minnesota' 
             24 'Mississippi' 25 'Missouri' 26 'Montana' 27 'Nebraska' 
             28 'Nevada' 29 'New Hampshire' 30 'New Jersey' 31 'New Mexico' 
             32 'New York' 33 'North Carolina' 34 'North Dakota' 35 'Ohio' 
             36 'Oklahoma' 37 'Oregon' 38 'Pennsylvania' 39 'Rhode Island' 
             40 'South Carolina' 41 'South Dakota' 42 'Tennessee' 43 'Texas' 
             44 'Utah' 45 'Vermont' 46 'Virginia' 47 'Washington' 
             48 'Washington D.C.' 49 'West Virginia' 50 'Wisconsin' 
             51 'Wyoming' 99 'Refused/Not Answered' /
   Q39_OCUS  1 'Puerto Rico' 2 'US Virgin Islands' 
             3 'Elsewhere outside the U.S.' 9 'Refused/Not Answered' /
   .

COMMENT  md, min and max specifications were translated into the
COMMENT following "MISSING VALUES" commands and "IF" statements:.

MISSING VALUES  complete (9).
MISSING VALUES  batch (999).
MISSING VALUES  facilityID (999).
MISSING VALUES  consent (9).
IF (consent LT 0) consent = $SYSMIS.
MISSING VALUES  Q1 (99).
IF (Q1 LT 1) Q1 = $SYSMIS.
MISSING VALUES  Q1_spec (9).
IF (Q1_spec LT 0) Q1_spec = $SYSMIS.
MISSING VALUES  Q4 (99).
IF (Q4 LT 1) Q4 = $SYSMIS.
MISSING VALUES  Q7_1 (9).
IF (Q7_1 LT 1) Q7_1 = $SYSMIS.
MISSING VALUES  Q7_2 (9).
IF (Q7_2 LT 1) Q7_2 = $SYSMIS.
MISSING VALUES  Q7_3 (9).
IF (Q7_3 LT 1) Q7_3 = $SYSMIS.
MISSING VALUES  Q7_4 (9).
IF (Q7_4 LT 1) Q7_4 = $SYSMIS.
MISSING VALUES  Q7_5 (9).
IF (Q7_5 LT 1) Q7_5 = $SYSMIS.
MISSING VALUES  Q7_7 (9).
IF (Q7_7 LT 1) Q7_7 = $SYSMIS.
MISSING VALUES  Q7_8 (9).
IF (Q7_8 LT 1) Q7_8 = $SYSMIS.
MISSING VALUES  Q7_9 (9).
IF (Q7_9 LT 1) Q7_9 = $SYSMIS.
MISSING VALUES  Q7_10 (9).
IF (Q7_10 LT 1) Q7_10 = $SYSMIS.
MISSING VALUES  Q7_11 (9).
IF (Q7_11 LT 1) Q7_11 = $SYSMIS.
MISSING VALUES  Q7_12 (9).
IF (Q7_12 LT 1) Q7_12 = $SYSMIS.
MISSING VALUES  Q7_13 (9).
IF (Q7_13 LT 1) Q7_13 = $SYSMIS.
MISSING VALUES  Q7_14 (9).
IF (Q7_14 LT 1) Q7_14 = $SYSMIS.
MISSING VALUES  Q7_15 (9).
IF (Q7_15 LT 1) Q7_15 = $SYSMIS.
MISSING VALUES  Q7_16 (9).
IF (Q7_16 LT 1) Q7_16 = $SYSMIS.
MISSING VALUES  Q7_17 (9).
IF (Q7_17 LT 1) Q7_17 = $SYSMIS.
MISSING VALUES  Q7_18 (9).
IF (Q7_18 LT 1) Q7_18 = $SYSMIS.
MISSING VALUES  Q7_19 (9).
IF (Q7_19 LT 1) Q7_19 = $SYSMIS.
MISSING VALUES  Q7_20 (9).
IF (Q7_20 LT 1) Q7_20 = $SYSMIS.
MISSING VALUES  Q7_21 (9).
IF (Q7_21 LT 1) Q7_21 = $SYSMIS.
MISSING VALUES  Q7_23 (9).
IF (Q7_23 LT 1) Q7_23 = $SYSMIS.
MISSING VALUES  Q7_24 (9).
IF (Q7_24 LT 1) Q7_24 = $SYSMIS.
MISSING VALUES  Q7_26 (9).
IF (Q7_26 LT 1) Q7_26 = $SYSMIS.
MISSING VALUES  Q7_27 (9).
IF (Q7_27 LT 1) Q7_27 = $SYSMIS.
MISSING VALUES  Q7_28 (9).
IF (Q7_28 LT 1) Q7_28 = $SYSMIS.
MISSING VALUES  Q7_29 (9).
IF (Q7_29 LT 1) Q7_29 = $SYSMIS.
MISSING VALUES  Q7_30 (9).
IF (Q7_30 LT 1) Q7_30 = $SYSMIS.
MISSING VALUES  Q8_1 (9).
IF (Q8_1 LT 1) Q8_1 = $SYSMIS.
MISSING VALUES  Q8_2 (9).
IF (Q8_2 LT 1) Q8_2 = $SYSMIS.
MISSING VALUES  Q8_3 (9).
IF (Q8_3 LT 1) Q8_3 = $SYSMIS.
MISSING VALUES  Q8_5 (9).
IF (Q8_5 LT 1) Q8_5 = $SYSMIS.
MISSING VALUES  Q8_6 (9).
IF (Q8_6 LT 1) Q8_6 = $SYSMIS.
MISSING VALUES  Q8_7 (9).
IF (Q8_7 LT 1) Q8_7 = $SYSMIS.
MISSING VALUES  Q8_10 (9).
IF (Q8_10 LT 1) Q8_10 = $SYSMIS.
MISSING VALUES  Q8_11 (9).
IF (Q8_11 LT 1) Q8_11 = $SYSMIS.
MISSING VALUES  Q8_12 (9).
IF (Q8_12 LT 1) Q8_12 = $SYSMIS.
MISSING VALUES  Q10 (9).
IF (Q10 LT 1) Q10 = $SYSMIS.
MISSING VALUES  Q11 (9).
IF (Q11 LT 1) Q11 = $SYSMIS.
MISSING VALUES  Q12 (9).
IF (Q12 LT 1) Q12 = $SYSMIS.
MISSING VALUES  Q13 (9).
IF (Q13 LT 0) Q13 = $SYSMIS.
MISSING VALUES  Q14 (9).
IF (Q14 LT 0) Q14 = $SYSMIS.
MISSING VALUES  Q15 (9).
IF (Q15 LT 1) Q15 = $SYSMIS.
MISSING VALUES  Q17 (9).
IF (Q17 LT 1) Q17 = $SYSMIS.
MISSING VALUES  Q18 (9).
IF (Q18 LT 1) Q18 = $SYSMIS.
MISSING VALUES  Q41_1 (9).
IF (Q41_1 LT 0) Q41_1 = $SYSMIS.
MISSING VALUES  Q41_2 (9).
IF (Q41_2 LT 0) Q41_2 = $SYSMIS.
MISSING VALUES  Q41_3 (9).
IF (Q41_3 LT 0) Q41_3 = $SYSMIS.
MISSING VALUES  Q41_4 (9).
IF (Q41_4 LT 0) Q41_4 = $SYSMIS.
MISSING VALUES  Q41_5 (9).
IF (Q41_5 LT 0) Q41_5 = $SYSMIS.
MISSING VALUES  Q41_6 (9).
IF (Q41_6 LT 0) Q41_6 = $SYSMIS.
MISSING VALUES  Q41_7 (9).
IF (Q41_7 LT 0) Q41_7 = $SYSMIS.
MISSING VALUES  Q41_8 (9).
IF (Q41_8 LT 0) Q41_8 = $SYSMIS.
MISSING VALUES  Q41_9 (9).
IF (Q41_9 LT 0) Q41_9 = $SYSMIS.
MISSING VALUES  Q41_10 (9).
IF (Q41_10 LT 0) Q41_10 = $SYSMIS.
MISSING VALUES  Q42a (9).
IF (Q42a LT 0) Q42a = $SYSMIS.
MISSING VALUES  Q42b (9).
IF (Q42b LT 0) Q42b = $SYSMIS.
MISSING VALUES  Q42c (9).
IF (Q42c LT 0) Q42c = $SYSMIS.
MISSING VALUES  Q42d (9).
IF (Q42d LT 0) Q42d = $SYSMIS.
MISSING VALUES  Q43a (9).
IF (Q43a LT 0) Q43a = $SYSMIS.
MISSING VALUES  Q43b (9).
IF (Q43b LT 0) Q43b = $SYSMIS.
MISSING VALUES  Q43c (9).
IF (Q43c LT 0) Q43c = $SYSMIS.
MISSING VALUES  Q43d (9).
IF (Q43d LT 0) Q43d = $SYSMIS.
MISSING VALUES  Q44a (9).
IF (Q44a LT 0) Q44a = $SYSMIS.
MISSING VALUES  Q44b (9).
IF (Q44b LT 0) Q44b = $SYSMIS.
MISSING VALUES  Q44c (9).
IF (Q44c LT 0) Q44c = $SYSMIS.
MISSING VALUES  Q44d (9).
IF (Q44d LT 0) Q44d = $SYSMIS.
MISSING VALUES  Q45a (9).
IF (Q45a LT 0) Q45a = $SYSMIS.
MISSING VALUES  Q45b (9).
IF (Q45b LT 0) Q45b = $SYSMIS.
MISSING VALUES  Q45c (9).
IF (Q45c LT 0) Q45c = $SYSMIS.
MISSING VALUES  Q45d (9).
IF (Q45d LT 0) Q45d = $SYSMIS.
MISSING VALUES  Q46a (9).
IF (Q46a LT 0) Q46a = $SYSMIS.
MISSING VALUES  Q46b (9).
IF (Q46b LT 0) Q46b = $SYSMIS.
MISSING VALUES  Q46c (9).
IF (Q46c LT 0) Q46c = $SYSMIS.
MISSING VALUES  Q46d (9).
IF (Q46d LT 0) Q46d = $SYSMIS.
MISSING VALUES  Q47a (9).
IF (Q47a LT 0) Q47a = $SYSMIS.
MISSING VALUES  Q47b (9).
IF (Q47b LT 0) Q47b = $SYSMIS.
MISSING VALUES  Q47c (9).
IF (Q47c LT 0) Q47c = $SYSMIS.
MISSING VALUES  Q47d (9).
IF (Q47d LT 0) Q47d = $SYSMIS.
MISSING VALUES  Q48a (9).
IF (Q48a LT 0) Q48a = $SYSMIS.
MISSING VALUES  Q48b (9).
IF (Q48b LT 0) Q48b = $SYSMIS.
MISSING VALUES  Q48c (9).
IF (Q48c LT 0) Q48c = $SYSMIS.
MISSING VALUES  Q48d (9).
IF (Q48d LT 0) Q48d = $SYSMIS.
MISSING VALUES  Q49a (9).
IF (Q49a LT 0) Q49a = $SYSMIS.
MISSING VALUES  Q49b (9).
IF (Q49b LT 0) Q49b = $SYSMIS.
MISSING VALUES  Q49c (9).
IF (Q49c LT 0) Q49c = $SYSMIS.
MISSING VALUES  Q49d (9).
IF (Q49d LT 0) Q49d = $SYSMIS.
MISSING VALUES  Q50a (9).
IF (Q50a LT 0) Q50a = $SYSMIS.
MISSING VALUES  Q50b (9).
IF (Q50b LT 0) Q50b = $SYSMIS.
MISSING VALUES  Q50c (9).
IF (Q50c LT 0) Q50c = $SYSMIS.
MISSING VALUES  Q50d (9).
IF (Q50d LT 0) Q50d = $SYSMIS.
MISSING VALUES  Q51a (9).
IF (Q51a LT 0) Q51a = $SYSMIS.
MISSING VALUES  Q51b (9).
IF (Q51b LT 0) Q51b = $SYSMIS.
MISSING VALUES  Q51c (9).
IF (Q51c LT 0) Q51c = $SYSMIS.
MISSING VALUES  Q51d (9).
IF (Q51d LT 0) Q51d = $SYSMIS.
MISSING VALUES  Q52a (9).
IF (Q52a LT 0) Q52a = $SYSMIS.
MISSING VALUES  Q52b (9).
IF (Q52b LT 0) Q52b = $SYSMIS.
MISSING VALUES  Q52c (9).
IF (Q52c LT 0) Q52c = $SYSMIS.
MISSING VALUES  Q52d (9).
IF (Q52d LT 0) Q52d = $SYSMIS.
MISSING VALUES  Q53a (9).
IF (Q53a LT 0) Q53a = $SYSMIS.
MISSING VALUES  Q53b (9).
IF (Q53b LT 0) Q53b = $SYSMIS.
MISSING VALUES  Q53c (9).
IF (Q53c LT 0) Q53c = $SYSMIS.
MISSING VALUES  Q53d (9).
IF (Q53d LT 0) Q53d = $SYSMIS.
MISSING VALUES  Q54a (9).
IF (Q54a LT 0) Q54a = $SYSMIS.
MISSING VALUES  Q54b (9).
IF (Q54b LT 0) Q54b = $SYSMIS.
MISSING VALUES  Q54c (9).
IF (Q54c LT 0) Q54c = $SYSMIS.
MISSING VALUES  Q54d (9).
IF (Q54d LT 0) Q54d = $SYSMIS.
MISSING VALUES  Q55a (9).
IF (Q55a LT 0) Q55a = $SYSMIS.
MISSING VALUES  Q55b (9).
IF (Q55b LT 0) Q55b = $SYSMIS.
MISSING VALUES  Q55c (9).
IF (Q55c LT 0) Q55c = $SYSMIS.
MISSING VALUES  Q55d (9).
IF (Q55d LT 0) Q55d = $SYSMIS.
MISSING VALUES  Q56a (9).
IF (Q56a LT 0) Q56a = $SYSMIS.
MISSING VALUES  Q56b (9).
IF (Q56b LT 0) Q56b = $SYSMIS.
MISSING VALUES  Q56c (9).
IF (Q56c LT 0) Q56c = $SYSMIS.
MISSING VALUES  Q56d (9).
IF (Q56d LT 0) Q56d = $SYSMIS.
MISSING VALUES  Q57a (9).
IF (Q57a LT 0) Q57a = $SYSMIS.
MISSING VALUES  Q57b (9).
IF (Q57b LT 0) Q57b = $SYSMIS.
MISSING VALUES  Q57c (9).
IF (Q57c LT 0) Q57c = $SYSMIS.
MISSING VALUES  Q57d (9).
IF (Q57d LT 0) Q57d = $SYSMIS.
MISSING VALUES  Q58a (9).
IF (Q58a LT 0) Q58a = $SYSMIS.
MISSING VALUES  Q58b (9).
IF (Q58b LT 0) Q58b = $SYSMIS.
MISSING VALUES  Q58c (9).
IF (Q58c LT 0) Q58c = $SYSMIS.
MISSING VALUES  Q58d (9).
IF (Q58d LT 0) Q58d = $SYSMIS.
MISSING VALUES  Q59a (9).
IF (Q59a LT 0) Q59a = $SYSMIS.
MISSING VALUES  Q59b (9).
IF (Q59b LT 0) Q59b = $SYSMIS.
MISSING VALUES  Q59c (9).
IF (Q59c LT 0) Q59c = $SYSMIS.
MISSING VALUES  Q59d (9).
IF (Q59d LT 0) Q59d = $SYSMIS.
MISSING VALUES  Q60a (9).
IF (Q60a LT 0) Q60a = $SYSMIS.
MISSING VALUES  Q60b (9).
IF (Q60b LT 0) Q60b = $SYSMIS.
MISSING VALUES  Q60c (9).
IF (Q60c LT 0) Q60c = $SYSMIS.
MISSING VALUES  Q60d (9).
IF (Q60d LT 0) Q60d = $SYSMIS.
MISSING VALUES  Q61a (9).
IF (Q61a LT 0) Q61a = $SYSMIS.
MISSING VALUES  Q61b (9).
IF (Q61b LT 0) Q61b = $SYSMIS.
MISSING VALUES  Q61c (9).
IF (Q61c LT 0) Q61c = $SYSMIS.
MISSING VALUES  Q61d (9).
IF (Q61d LT 0) Q61d = $SYSMIS.
MISSING VALUES  Q21 (9).
IF (Q21 LT 1) Q21 = $SYSMIS.
MISSING VALUES  Q22 (9).
IF (Q22 LT 1) Q22 = $SYSMIS.
MISSING VALUES  Q23_1 (9).
IF (Q23_1 LT 0) Q23_1 = $SYSMIS.
MISSING VALUES  Q23_2 (9).
IF (Q23_2 LT 0) Q23_2 = $SYSMIS.
MISSING VALUES  Q23_3 (9).
IF (Q23_3 LT 0) Q23_3 = $SYSMIS.
MISSING VALUES  Q23_4 (9).
IF (Q23_4 LT 0) Q23_4 = $SYSMIS.
MISSING VALUES  Q23_5 (9).
IF (Q23_5 LT 0) Q23_5 = $SYSMIS.
MISSING VALUES  Q23_6 (9).
IF (Q23_6 LT 0) Q23_6 = $SYSMIS.
MISSING VALUES  Q23_spec (9).
IF (Q23_spec LT 0) Q23_spec = $SYSMIS.
MISSING VALUES  Q2 (99).
IF (Q2 LT 0) Q2 = $SYSMIS.
MISSING VALUES  Q3 (99).
IF (Q3 LT 0) Q3 = $SYSMIS.
MISSING VALUES  Q40 (9).
IF (Q40 LT 1) Q40 = $SYSMIS.
MISSING VALUES  Q24 (9).
IF (Q24 LT 1) Q24 = $SYSMIS.
MISSING VALUES  Q25 (9).
IF (Q25 LT 1) Q25 = $SYSMIS.
MISSING VALUES  Q26 (9).
IF (Q26 LT 1) Q26 = $SYSMIS.
MISSING VALUES  Q27 (9).
IF (Q27 LT 1) Q27 = $SYSMIS.
MISSING VALUES  Q28 (9).
IF (Q28 LT 1) Q28 = $SYSMIS.
MISSING VALUES  Q29 (9).
IF (Q29 LT 1) Q29 = $SYSMIS.
MISSING VALUES  Q29_spec (9).
IF (Q29_spec LT 0) Q29_spec = $SYSMIS.
MISSING VALUES  Q30 (9).
IF (Q30 LT 1) Q30 = $SYSMIS.
MISSING VALUES  Q31 (9).
IF (Q31 LT 1) Q31 = $SYSMIS.
MISSING VALUES  Q32 (9).
IF (Q32 LT 1) Q32 = $SYSMIS.
MISSING VALUES  Q33 (99).
IF (Q33 LT 0) Q33 = $SYSMIS.
MISSING VALUES  Q34 (99).
IF (Q34 LT 0) Q34 = $SYSMIS.
MISSING VALUES  Q34_DNC (9).
IF (Q34_DNC LT 0) Q34_DNC = $SYSMIS.
MISSING VALUES  Q35 (9).
IF (Q35 LT 1) Q35 = $SYSMIS.
MISSING VALUES  Q35_spec (9).
IF (Q35_spec LT 0) Q35_spec = $SYSMIS.
MISSING VALUES  Q36 (9).
IF (Q36 LT 1) Q36 = $SYSMIS.
MISSING VALUES  Q37 (99).
IF (Q37 LT 0) Q37 = $SYSMIS.
MISSING VALUES  Q38 (99).
IF (Q38 LT 0) Q38 = $SYSMIS.
MISSING VALUES  Q39_SW (9).
IF (Q39_SW LT 1) Q39_SW = $SYSMIS.
MISSING VALUES  Q39_ICUS (99).
IF (Q39_ICUS LT 1) Q39_ICUS = $SYSMIS.
MISSING VALUES  Q39_OCUS (9).
IF (Q39_OCUS LT 1) Q39_OCUS = $SYSMIS.

SAVE OUTFILE="L:\survey\NICHE\Cohort 4\data export\2019-05-17\alldata.sav"  /* Replace 'y' with name to give your system file
   /MAP
   /COMPRESSED  /* Delete this line if you want an uncompressed file
   .
