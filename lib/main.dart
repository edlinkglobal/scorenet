 import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:country_picker/country_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){runApp(const ScoreNetApp());}

class Config{
  // YOUR LINK - 1xPartners
  static const String affBase = "https://reffpa.com/L?tag=d_6098780m_85720c_scorenet_app&site=6098780&ad=85720";
  static String link(String sub) => "$affBase&subid=${sub}_scorenet";
}

class TG{
  static String g(){var h=DateTime.now().hour;if(h<12)return"Good Morning";if(h<17)return"Good Afternoon";if(h<21)return"Good Evening";return"Good Night";}
  static String d()=>DateFormat('EEEE, MMM d • HH:mm').format(DateTime.now());
  static String f(String c){if(c.length!=2)return"🇬🇭";return c.toUpperCase().codeUnits.map((e)=>String.fromCharCode(e-0x41+0x1F1E6)).join();}
  static Future<Map> det()async{
    try{var r=await http.get(Uri.parse("https://ipapi.co/json/")).timeout(Duration(seconds:5));
      if(r.statusCode==200){var j=jsonDecode(r.body);return{"co":j['country_name'],"cc":j['country_code'],"cur":j['currency']??"GHS","city":j['city']};}
    }catch(_){}
    return{"co":"Ghana","cc":"GH","cur":"GHS","city":"Accra"};
  }
}

class Pay{
  static Map<String,double> rt={"GHS":1,"NGN":110,"KES":10.5,"ZAR":1.2,"USD":0.065,"GBP":0.052,"EUR":0.06};
  static Map<String,String> sy={"GHS":"GH₵","NGN":"₦","KES":"KSh","ZAR":"R","USD":"\$","GBP":"£","EUR":"€"};
  static Future<double> cv(String cur,double b)async{
    try{var r=await http.get(Uri.parse("https://api.exchangerate-api.com/v4/latest/GHS")).timeout(Duration(seconds:4));
      if(r.statusCode==200){var m=jsonDecode(r.body)['rates'];if(m[cur]!=null)return b*(m[cur] as num).toDouble();}
    }catch(_){}
    return b*(rt[cur]??1);
  }
  static String fm(double a,String c)=>"${sy[c]??c}${a.toStringAsFixed(2)}";
}

class Api{
  static const k="286097419ada4698b7f98f1d8932e38b";
  static Future<List> today()async{
    final t=DateFormat('yyyy-MM-dd').format(DateTime.now());
    try{var r=await http.get(Uri.parse('https://api.football-data.org/v4/matches?dateFrom=$t&dateTo=$t'),headers:{'X-Auth-Token':k}).timeout(Duration(seconds:10));
      if(r.statusCode==200)return jsonDecode(r.body)['matches']??[];}catch(_){}
    return[];
  }
  static Future<List> live()async{
    try{var r=await http.get(Uri.parse('https://api.football-data.org/v4/matches?status=LIVE,IN_PLAY,PAUSED'),headers:{'X-Auth-Token':k}).timeout(Duration(seconds:10));
      if(r.statusCode==200)return jsonDecode(r.body)['matches']??[];}catch(_){}
    return[];
  }
}

// ===== SAFE BANNER ADVERT - NOT ADMOB - GOOGLE & PAYSTACK SAFE =====
class Aff{
  // ATTRACTIVE BANNER TEMPLATE
  static Widget banner(BuildContext ctx, String placement){
    return InkWell(
      onTap:()=>open(ctx, placement),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: EdgeInsets.symmetric(vertical:8),
        height: 96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF0A1931), Color(0xFF1A4DA1), Color(0xFF2E86DE)]),
        ),
        child: Stack(children:[
          // Top small disclosure - GOOGLE SAFE
          Positioned(left:10,top:6,child:Container(padding:EdgeInsets.symmetric(horizontal:6,vertical:2),decoration:BoxDecoration(color:Colors.black54,borderRadius:BorderRadius.circular(4)),child:Text("AD • SPONSORED • THIRD PARTY • 18+",style:TextStyle(color:Colors.white,fontSize:7,fontWeight:FontWeight.bold,letterSpacing:0.5)))),

          // Main content
          Positioned(left:12,top:24,right:12,bottom:20,child:Row(children:[
            Container(width:52,height:52,decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(10),boxShadow:[BoxShadow(color:Colors.black26,blurRadius:4)]),child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text("1XBET",style:TextStyle(fontWeight:FontWeight.w900,color:Color(0xFF0A1931),fontSize:12)),Text("OFFICIAL",style:TextStyle(fontSize:7,color:Color(0xFF0A1931)))]))),
            SizedBox(width:12),
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[
              Text("BEST ODDS - VIEW NOW!",style:TextStyle(color:Colors.white,fontWeight:FontWeight.w900,fontSize:14,letterSpacing:0.3)),
              SizedBox(height:2),
              Text("Top boosted odds • Live action • Fast payout",style:TextStyle(color:Color(0xFFFFE082),fontSize:10,fontWeight:FontWeight.w600)),
              SizedBox(height:3),
              Row(children:[
                Container(padding:EdgeInsets.symmetric(horizontal:6,vertical:2),decoration:BoxDecoration(color:Color(0xFFFFD700),borderRadius:BorderRadius.circular(4)),child:Text("🔥 HOT ODDS",style:TextStyle(fontSize:8,fontWeight:FontWeight.bold,color:Colors.black))),
                SizedBox(width:4),
                Text("18+ Bet Responsibly",style:TextStyle(color:Colors.white70,fontSize:8)),
              ]),
            ])),
            Container(padding:EdgeInsets.symmetric(horizontal:14,vertical:10),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(24),boxShadow:[BoxShadow(color:Colors.black26,blurRadius:4)]),child:Row(children:[Text("View",style:TextStyle(fontWeight:FontWeight.bold,fontSize:13,color:Color(0xFF0A1931))),SizedBox(width:2),Icon(Icons.arrow_forward,size:14,color:Color(0xFF0A1931))])),
          ])),

          // Bottom disclosure - PAYSTACK SAFE
          Positioned(left:10,bottom:4,right:10,child:Text("Sponsored third-party content • External site • Not part of ScoreNet • 18+ only",style:TextStyle(color:Colors.white60,fontSize:6),textAlign:TextAlign.center)),
        ]),
      ),
    );
  }

  static Future<void> open(BuildContext ctx, String sub)async{
    var p=await SharedPreferences.getInstance();
    if(!(p.getBool('age_verified')??false)){ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content:Text("Please verify 18+ first in Me tab")));return;}
    bool ok=await showDialog(context:ctx,barrierDismissible:false,builder:(_)=>AlertDialog(
      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
      title:Row(children:[Icon(Icons.shield,size:18,color:Color(0xFF0A1931)),SizedBox(width:6),Text("Sponsored Partner • 18+",style:TextStyle(fontSize:14))]),
      content:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text("You are leaving ScoreNet to view third-party sponsored content from our Official Sports Partner.",style:TextStyle(fontSize:11)),
        SizedBox(height:8),
        Container(padding:EdgeInsets.all(8),decoration:BoxDecoration(color:Color(0xFFF1F5F9),borderRadius:BorderRadius.circular(8)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text("• External website - not part of ScoreNet",style:TextStyle(fontSize:10)),
          Text("• 18+ Only - For adults",style:TextStyle(fontSize:10,fontWeight:FontWeight.bold)),
          Text("• Bet Responsibly - Gambling is risky",style:TextStyle(fontSize:10)),
          Text("• Third-party ad - ScoreNet shows live scores only",style:TextStyle(fontSize:10)),
        ])),
      ]),
      actions:[TextButton(onPressed:()=>Navigator.pop(ctx,false),child:Text("Cancel")),ElevatedButton(onPressed:()=>Navigator.pop(ctx,true),style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF0A1931)),child:Text("Continue to Partner",style:TextStyle(color:Colors.white,fontSize:12)))],
    ))??false;
    if(!ok)return;
    await launchUrl(Uri.parse(Config.link(sub)),mode:LaunchMode.externalApplication);
  }
}

class AgeGate extends StatefulWidget{const AgeGate({super.key});@override State<AgeGate> createState()=>_AgeGateS();}
class _AgeGateS extends State<AgeGate>{
  bool t1=false,t2=false,load=true;
  @override void initState(){super.initState();chk();}
  Future<void>chk()async{var p=await SharedPreferences.getInstance();if(p.getBool('age_verified')??false){if(mounted)Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const Main()));}else setState(()=>load=false);}
  Future<void>go()async{if(!t1||!t2)return;var p=await SharedPreferences.getInstance();await p.setBool('age_verified',true);if(mounted)Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const Main()));}
  @override Widget build(BuildContext c){
    if(load)return Scaffold(body:Center(child:CircularProgressIndicator()));
    return Scaffold(body:SafeArea(child:Padding(padding:EdgeInsets.all(20),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Center(child:Container(width:64,height:64,decoration:BoxDecoration(color:Color(0xFF0A1931),borderRadius:BorderRadius.circular(16)),child:Center(child:Text("⚽",style:TextStyle(fontSize:36))))),
      SizedBox(height:12),
      Center(child:Text("ScoreNet",style:TextStyle(fontSize:26,fontWeight:FontWeight.bold,color:Color(0xFF0A1931)))),
      Center(child:Text("Worldwide Live Scores",style:TextStyle(color:Colors.grey,fontSize:12))),
      SizedBox(height:20),
      Text("Confirm to continue:",style:TextStyle(fontWeight:FontWeight.bold)),
      CheckboxListTile(value:t1,onChanged:(v)=>setState(()=>t1=v!),title:Text("I am 18 years or older (18+)",style:TextStyle(fontSize:14,fontWeight:FontWeight.bold)),subtitle:Text("Required because app shows optional sponsored sports content for adults.",style:TextStyle(fontSize:11)),controlAffinity:ListTileControlAffinity.leading),
      CheckboxListTile(value:t2,onChanged:(v)=>setState(()=>t2=v!),title:Text("I agree to Terms",style:TextStyle(fontSize:14,fontWeight:FontWeight.bold)),subtitle:Text("ScoreNet is live scores only. Sponsored banners are external, optional, third-party, 18+. Donations are voluntary app support, not betting. Bet responsibly.",style:TextStyle(fontSize:11)),controlAffinity:ListTileControlAffinity.leading),
      Spacer(),
      Container(padding:EdgeInsets.all(10),decoration:BoxDecoration(color:Color(0xFFF3F4F6),borderRadius:BorderRadius.circular(8)),child:Text("Safe: No gambling in-app. No AdMob. Banners = third-party sponsored, open externally. Donations = app support only.",style:TextStyle(fontSize:10))),
      SizedBox(height:12),
      SizedBox(width:double.infinity,height:48,child:ElevatedButton(onPressed:(t1&&t2)?go:null,style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF0A1931)),child:Text("Continue to ScoreNet",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)))),
    ]))));}
}

class ScoreNetApp extends StatelessWidget{const ScoreNetApp({super.key});@override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false,home:const AgeGate(),theme:ThemeData(useMaterial3:true,scaffoldBackgroundColor:Color(0xFFF8FAFC)));}}
class Main extends StatefulWidget{const Main({super.key});@override State<Main> createState()=>_MainS();}
class _MainS extends State<Main>{int idx=0;String co="Ghana",cc="GH",cur="GHS",city="Accra",name="Alex";String gr=TG.g();Timer? cl;@override void initState(){super.initState();init();cl=Timer.periodic(Duration(seconds:1),(_)=>setState(()=>gr=TG.g()));}Future<void>init()async{var l=await TG.det();setState(()=>{co=l['co'],cc=l['cc'],cur=l['cur'],city=l['city']});}@override void dispose(){cl?.cancel();super.dispose();}@override Widget build(BuildContext c){final pages=[MatchesT(co:co,cc:cc,cur:cur,name:name,city:city),LiveT(),FavT(),InsightsT(),LeaguesT(),NewsT(),MeT(co:co,cc:cc,cur:cur,name:name,city:city,onChanged:(a,b,c1,d)=>setState(()=>{co=a,cc=b,cur=c1,city=d}))];return Scaffold(body:pages[idx],bottomNavigationBar:NavigationBar(selectedIndex:idx,onDestinationSelected:(i)=>setState(()=>idx=i),destinations:const[NavigationDestination(icon:Icon(Icons.sports_soccer),label:'Matches'),NavigationDestination(icon:Icon(Icons.live_tv,color:Colors.red),label:'Live'),NavigationDestination(icon:Icon(Icons.star),label:'Favorite'),NavigationDestination(icon:Icon(Icons.insights),label:'Insights'),NavigationDestination(icon:Icon(Icons.emoji_events),label:'Leagues'),NavigationDestination(icon:Icon(Icons.newspaper),label:'News'),NavigationDestination(icon:Icon(Icons.person),label:'Me')]));}}

class MatchesT extends StatefulWidget{final String co,cc,cur,name,city;const MatchesT({super.key,required this.co,required this.cc,required this.cur,required this.name,required this.city});@override State<MatchesT> createState()=>_MatchesTS();}
class _MatchesTS extends State<MatchesT>{List m=[];bool ld=true;Timer? p;@override void initState(){super.initState();ft();p=Timer.periodic(Duration(seconds:30),(_)=>ft());}Future<void>ft()async{setState(()=>ld=true);var d=await Api.today();setState(()=>{m=d,ld=false});}@override void dispose(){p?.cancel();super.dispose();}@override Widget build(BuildContext c){return SafeArea(child:Column(children:[Padding(padding:EdgeInsets.all(12),child:Row(children:[Container(width:40,height:40,decoration:BoxDecoration(color:Color(0xFF0A1931),borderRadius:BorderRadius.circular(8)),child:Center(child:Text("⚽",style:TextStyle(fontSize:24)))),SizedBox(width:8),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text("ScoreNet",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text("${TG.g()} • ${widget.city} ${TG.f(widget.cc)} • ${TG.d()}",style:TextStyle(fontSize:10,color:Colors.grey))]))])),Expanded(child:ld?Center(child:CircularProgressIndicator()):ListView.builder(padding:EdgeInsets.all(12),itemCount:m.length, itemBuilder:(c,i)=>Column(children:[if(i==2)Aff.banner(c,"matches_2"), MC(m:m[i]), if(i==5)Aff.banner(c,"matches_5")])))]));}}

class MC extends StatelessWidget{final dynamic m;const MC({super.key,required this.m});String mi(String u){try{var s=DateTime.parse(u);var d=DateTime.now().difference(s).inMinutes;if(d<0)return"NS";if(d>90)return d>120?"FT":"90+";if(d>=45&&d<60)return"HT";return"$d'";}catch(_){return"LIVE";}}@override Widget build(BuildContext c){String h=m['homeTeam']?['shortName']??m['homeTeam']?['name']??"Home";String a=m['awayTeam']?['shortName']??m['awayTeam']?['name']??"Away";int hs=m['score']?['fullTime']?['home']??m['score']?['live']?['home']??0;int aw=m['score']?['fullTime']?['away']??m['score']?['live']?['away']??0;return Container(margin:EdgeInsets.only(bottom:10),padding:EdgeInsets.all(12),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(14),boxShadow:[BoxShadow(color:Colors.black12,blurRadius:4)]),child:Column(children:[Row(children:[Text(m['competition']?['name']??"League",style:TextStyle(fontSize:9,color:Colors.grey)),Spacer(),Container(padding:EdgeInsets.symmetric(horizontal:6,vertical:2),decoration:BoxDecoration(color:Color(0xFF22C55E),borderRadius:BorderRadius.circular(6)),child:Text(mi(m['utcDate']??""),style:TextStyle(color:Colors.white,fontSize:9)))]),SizedBox(height:6),Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[Column(children:[Icon(Icons.shield,size:32),Text(h,style:TextStyle(fontSize:11,fontWeight:FontWeight.bold))]),Column(children:[Text("$hs - $aw",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text("Tap for details",style:TextStyle(fontSize:8,color:Colors.grey))]),Column(children:[Icon(Icons.shield,size:32),Text(a,style:TextStyle(fontSize:11,fontWeight:FontWeight.bold))])])]));}}

class LiveT extends StatefulWidget{const LiveT({super.key});@override State<LiveT> createState()=>_LiveTS();}
class _LiveTS extends State<LiveT>{List l=[];bool ld=true;Timer? t;@override void initState(){super.initState();f();t=Timer.periodic(Duration(seconds:30),(_)=>f());}Future<void>f()async{var d=await Api.live();setState(()=>{l=d,ld=false});}@override void dispose(){t?.cancel();super.dispose();}@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text("Live • 30s refresh")),body:ld?Center(child:CircularProgressIndicator()):l.isEmpty?Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text("No live matches now"),SizedBox(height:10),Aff.banner(c,"live_empty")])):ListView.builder(padding:EdgeInsets.all(12),itemCount:l.length,itemBuilder:(c,i)=>Column(children:[if(i==0)Aff.banner(c,"live_top"),MC(m:l[i])])));}
class FavT extends StatelessWidget{const FavT({super.key});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text("Favorite")),body:ListView(padding:EdgeInsets.all(12),children:[Aff.banner(c,"fav_top"),Center(child:Padding(padding:EdgeInsets.all(20),child:Text("Save favorites here")))]));}
class LeaguesT extends StatelessWidget{const LeaguesT({super.key});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text("Leagues")),body:ListView(padding:EdgeInsets.all(12),children:[Aff.banner(c,"leagues_top"),ListTile(title:Text("Premier League 🏴󠁧󠁢󠁥󠁮󠁧󠁿")),ListTile(title:Text("La Liga 🇪🇸")),ListTile(title:Text("Bundesliga 🇩🇪"))]));}
class NewsT extends StatelessWidget{const NewsT({super.key});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text("News")),body:ListView(padding:EdgeInsets.all(12),children:[Aff.banner(c,"news_top"),Card(child:ListTile(title:Text("Transfer News Live")))]));}
class InsightsT extends StatelessWidget{const InsightsT({super.key});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text("AI Insights")),body:ListView(padding:EdgeInsets.all(12),children:[Text("Win Prob: Home 55% Draw 20% Away 25%",style:TextStyle(fontWeight:FontWeight.bold)),LinearProgressIndicator(value:0.55),SizedBox(height:10),Aff.banner(c,"insights_mid"),Card(child:Padding(padding:EdgeInsets.all(12),child:Text("Form ●●●○● vs ○●●●○\nAI Confidence 78%\nModel improves after FT")))]));}

class MeT extends StatefulWidget{final String co,cc,cur,name,city;final Function(String,String,String,String) onChanged;const MeT({super.key,required this.co,required this.cc,required this.cur,required this.name,required this.city,required this.onChanged});@override State<MeT> createState()=>_MeTS();}
class _MeTS extends State<MeT>{double cd=5;@override void initState(){super.initState();ld();}Future<void>ld()async{cd=await Pay.cv(widget.cur,5);setState((){});}@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text("Me ${TG.f(widget.cc)}")),body:ListView(padding:EdgeInsets.all(16),children:[
  Container(padding:EdgeInsets.all(16),decoration:BoxDecoration(color:Color(0xFF0A1931),borderRadius:BorderRadius.circular(16)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text("${TG.g()} ${widget.name}! ${TG.f(widget.cc)}",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:16)),Text("${widget.city}, ${widget.co} • ${widget.cur} • Worldwide Auto",style:TextStyle(color:Colors.white70,fontSize:11)),Text("Min support: ${Pay.fm(cd,widget.cur)}",style:TextStyle(color:Color(0xFF22C55E),fontSize:11))])),
  ListTile(title:Text("Country: ${widget.co} ${TG.f(widget.cc)}"),subtitle:Text("Tap to change 195 countries - auto time/date/lang/currency"),onTap:(){showCountryPicker(context:c,showPhoneCode:false,onSelect:(Country co){String cur={"GH":"GHS","NG":"NGN","KE":"KES","ZA":"ZAR","US":"USD","GB":"GBP","DE":"EUR","FR":"EUR","ES":"EUR"}[co.countryCode]??"USD";widget.onChanged(co.name,co.countryCode,cur,co.name);ld();});}),
  Divider(),
  Text("ADVERTISEMENT - THIRD PARTY PARTNER",style:TextStyle(fontSize:8,color:Colors.grey,fontWeight:FontWeight.bold)),
  Aff.banner(c,"me_profile"),
  SizedBox(height:8),
  Card(child:ListTile(title:Text("Support ScoreNet - Donate ${Pay.fm(cd,widget.cur)}+"),subtitle:Text("Voluntary support - not betting - Paystack safe"),onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>DonPage(cur:widget.cur,co:widget.co,cc:widget.cc,name:widget.name))))),
  SizedBox(height:8),
  Center(child:Text("ScoreNet v1.0 • 18+ • Third-party sponsored • External • Bet Responsibly",style:TextStyle(fontSize:8,color:Colors.grey))),
]));}}

class DonPage extends StatefulWidget{final String cur,co,cc,name;const DonPage({super.key,required this.cur,required this.co,required this.cc,required this.name});@override State<DonPage> createState()=>_DonPageS();}
class _DonPageS extends State<DonPage>{double sel=5,conv=5;@override void initState(){super.initState();cv();}Future<void>cv()async{conv=await Pay.cv(widget.cur,sel);setState((){});} @override Widget build(BuildContext c){double min=widget.cur=="NGN"?550:widget.cur=="USD"?0.33:5;return Scaffold(appBar:AppBar(title:Text("Support - Min ${Pay.fm(min,widget.cur)}")),body:Padding(padding:EdgeInsets.all(16),child:Column(children:[Text("Support ScoreNet ❤️",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text("Voluntary app support only - not betting - Paystack/MoMo",style:TextStyle(fontSize:10,color:Colors.grey)),SizedBox(height:12),Wrap(spacing:6,children:[5,10,20,50].map((v)=>ChoiceChip(label:Text(Pay.fm(v.toDouble(),widget.cur)),selected:sel==v.toDouble(),onSelected:(_){setState(()=>sel=v.toDouble());cv();})).toList()),SizedBox(height:12),Text("You pay: ${Pay.fm(conv,widget.cur)}",style:TextStyle(fontWeight:FontWeight.bold)),SizedBox(height:16),SizedBox(width:double.infinity,height:48,child:ElevatedButton(onPressed:()async{await launchUrl(Uri.parse("https://paystack.com/pay/scorenet"),mode:LaunchMode.externalApplication);},style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF0A1931)),child:Text("Donate via Paystack / MoMo",style:TextStyle(color:Colors.white))))])));}}
