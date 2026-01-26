-- ### group by ###################################


-- 1. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.
select family, round(avg(LEG))
from TBLZOO
group by family;

-- 2. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.
select * from traffic_accident;
select trans_type, sum(TOTAL_ACCT_NUM), sum(DEATH_PERSON_NUM), round(avg(DEATH_PERSON_NUM))
from TRAFFIC_ACCIDENT
group by TRANS_TYPE;
    
-- 3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.
select * from TBLZOO;
select BREATH, count(*) from TBLZOO where THERMO = 'variable' group by BREATH;
        
-- 4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.
select SIZEOF, FAMILY, count(*) from TBLZOO group by SIZEOF, FAMILY;

-- 5. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
select email,count(email) from TBLADDRESSBOOK group by email having count(email) > 1;

-- 6. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.
select substr(name,1,1) from TBLADDRESSBOOK group by substr(name,1,1) having count(substr(name,1,1)) >= 100;

-- 7. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?
select job, count(
                case
                    when substr(address,1,2) = '서울' then 1
                end
            ), count(
               case
                    when substr(address,1,2) <> '서울' then 1
                end
               )
from TBLADDRESSBOOK group by job having job in('건물주', '건물주자제분');
