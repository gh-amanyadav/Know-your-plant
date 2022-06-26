

class DetailSpecies{
  final String specieName;
  const DetailSpecies({required this.specieName});
  static const List neem = ["Wound healer: Make a paste out of the neem leaves and dab it on your wounds or insect bites a few times a day till it heals.",
    "Eye Trouble: Boil some neem leaves, let the water cool completely and then use it to wash your eyes. This will help any kind of irritation, tiredness or redness.",
    "Boost immunity: Crush some neem leaves and take them with a glass of water to increase your immunity."];
  static const List  curry = ["May have pain-relieving properties: Research in rodents has shown that oral administration of curry extract significantly reduces induced pain.",
  "Has anti-inflammatory effects: Curry leaves contain a wide array of anti-inflammatory compounds, and animal research has shown that curry leaf extract can help reduce inflammation-related genes and proteins.",
  "Offers antibacterial properties: A test-tube study found that curry leaf extract inhibited the growth of potentially harmful bacteria, including Corynebacterium tuberculosis and Streptococcus pyogenes"];
  static const List jamun = ["Diabetes Management: Ayurveda suggests Jamun as a highly effective fruit while fighting against diabetes. The seeds of the fruit have active ingredients called jamboline and jambosine that slow down the rate of sugar released into the blood and increases the insulin levels in the body. It converts starch into energy and reduces the symptoms of diabetes such as frequent urination and thrusting.",
   "Healthy Heart: Jamun is laden with high amounts of potassium. It is extremely beneficial in keeping heart related ailments at a bay. Regular consumption of Jamun prevents hardening of arteries which leads to atherosclerosis, reduces the various symptoms of high blood pressure thereby controlling hypertension and prevents strokes and cardiac arrests. A serving of 100 gm jamun contains 79 mg of potassium which makes this juicy fruit appropriate for a high blood pressure diet.",
  "Oral Hygiene: Dried and powdered leaves of Jamun have anti-bacterial properties and is used as a tooth powder for strengthening teeth and gums. The fruit and leaves possess strong astringent properties, making it highly effective against throat problems and in eliminating bad breath. The decoction of the bark can be used as a mouth wash or gargled regularly to prevent mouth ulceration and gingivitis."];
  static const List lemon = ["Healing properties: The plant is useful against stomachache, gastri tis, intestinal pain, against parasites (antihelmintic) and spasms, for flatulence, pain in general, rheu matism, arthritis, headache, nervous attacks, mus cular pains, fever, vaginal diseases.",
   "Meniere's disease: There are some reports that a chemical in lemon called eriodictyol glycoside might improve hearing and decrease dizziness, nausea, and vomiting in some people with Meniere's disease.",
   "Kidney stones: Not having enough citrate in the urine seems to increase the risk of developing kidney stones. There is some evidence that drinking 2 liters of lemonade throughout the day can significantly raise citrate levels in the urine. This might help to prevent kidney stones in these people."];
  static const List tulsi = ["Diabetes: Tulsi may help to support a diet that is focused on reducing blood sugar", "Digestive Tract: Tulsi is used as a remedy for a range of gastrointestinal diseases as well as to improve appetite.", "Tulsi can help cure fever.",
  "Tulsi is used to treat insect bites.",
  "Tulsi leaves are used to treat skin problems like acne, blackheads and premature ageing.",];
  String shortDetails(String locationDetail){
    String detailsShort = "The leaf you have scanned is belongs to $specieName Species, which is mainly found in $locationDetail, India.";
    return detailsShort;
  }

  List longDetails(){
    if (specieName == "Curry"){
      return curry;
    }else if(specieName == "Jamun"){
      return jamun;
    }else if(specieName == "Lemon"){
      return lemon;
    }else if(specieName == "Neem"){
      return neem;
    }else if(specieName == "Tulsi"){
      return tulsi;
    }else{
      return ["Sorry to say but we're unable to detect your plant", "Scan Again Please!!"];
    }

  }
}