//
//  ContentView.swift
//  Yicheng_Li_Assignment4
//
//  Created by mac on 2021/5/22.
//

import SwiftUI
import MapKit

struct ContentView: View
{
    var body: some View
    {
        NavigationView
        {
            List
            {
                NavigationLink(destination: Hello())
                {
                    Text("Say \" hello\" ").padding(20)
                }
                NavigationLink(destination: calculator())
                {
                    Text("Calculator").padding(20)
                }
                NavigationLink(destination: Palette())
                {
                    Text("Palette").padding(20)
                }
                NavigationLink(destination: Map())
                {
                    Text("Get Location").padding(20)
                }
            }.navigationTitle("Tools").padding(.bottom,10.0)
        }
    }
}

struct Hello: View
{
    @State private var text = ""
    @State private var isAlertPresent = false
    
    var body: some View
    {
       VStack
       {
            Text("Hello").font(.title).padding(30)
            HStack
            {
                Text("Name:").frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                TextField("Type your name here", text: $text).textFieldStyle(RoundedBorderTextFieldStyle())
             }.padding([.top, .leading, .trailing])
             Button(action:{isAlertPresent = true})
             {Text("Get Alert")}.padding([.top, .leading, .trailing],50)
       }.alert(isPresented: $isAlertPresent)
       {
            Alert(title: Text("Hello"), message: Text("\(text)"),dismissButton: nil)
       }
    }
}

struct calculator: View
{
    @State private var text = "0"
    @State private var number:Double = 0.0
    @State private var flage:Int = 0
    @State private var num1:String = "";
    @State private var num2:String = "";
    @State private var operation:String  = "";
    
    var body: some View
    {
       VStack
       {
            Text(text).multilineTextAlignment(.trailing).font(.title).frame(width: 300, height: 40).background(Color.green)
            HStack
            {
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "7"}
                        else
                        {text = "7"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "7"}
                        else
                        {text = "7"}
                        num1 = text;
                    }
                })
                {Text("7").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "8"}
                        else
                        {text = "8"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "8"}
                        else
                        {text = "8"}
                        num1 = text;
                    }
                })
                {Text("8").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "9"}
                        else
                        {text = "9"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "9"}
                        else
                        {text = "9"}
                        num1 = text;
                    }
                })
                {Text("9").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if(num2 != "")
                    {
                        text = comput(num1: num1, operation: operation, num2: num2);
                        num1 = text;
                        num2 = "";
                        operation = "+";
                    }
                    else
                    {
                        if(num1 != "")
                        {
                            operation = "+";
                        }
                    }
                })
                {Text("+").foregroundColor(Color.red)}.padding(.all,20).frame(width: 50, height: 40).background(Color.yellow)
                
            }.padding([.top, .leading, .trailing])
            HStack
            {
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "4"}
                        else
                        {text = "4"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "4"}
                        else
                        {text = "4"}
                        num1 = text;
                    }
                })
                {Text("4").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "5"}
                        else
                        {text = "5"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "5"}
                        else
                        {text = "5"}
                        num1 = text;
                    }
                })
                {Text("5").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "6"}
                        else
                        {text = "6"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "6"}
                        else
                        {text = "6"}
                        num1 = text;
                    }
                })
                {Text("6").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if(num2 != "")
                    {
                        text = comput(num1: num1, operation: operation, num2: num2);
                        num1 = text;
                        num2 = "";
                        operation = "-";
                    }
                    else
                    {
                        if(num1 != "")
                        {
                            operation = "-";
                        }
                    }
                })
                {Text("-").foregroundColor(Color.red)}.padding(.all,20).frame(width: 50, height: 40).background(Color.yellow)
                
            }.padding([.top, .leading, .trailing])
            HStack
            {
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "1"}
                        else
                        {text = "1"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "1"}
                        else
                        {text = "1"}
                        num1 = text;
                    }
                })
                {Text("1").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "2"}
                        else
                        {text = "2"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "2"}
                        else
                        {text = "2"}
                        num1 = text;
                    }
                })
                {Text("2").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "3"}
                        else
                        {text = "3"}
                        num2 = text;
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "3"}
                        else
                        {text = "3"}
                        num1 = text;
                    }
                })
                {Text("3").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if(num2 != "")
                    {
                        text = comput(num1: num1, operation: operation, num2: num2);
                        num1 = text
                        num2 = ""
                        operation = "*";
                    }
                    else
                    {
                        if(num1 != "")
                        {
                            operation = "*";
                        }
                    }
                })
                {Text("x").foregroundColor(Color.red)}.padding(.all,20).frame(width: 50, height: 40).background(Color.yellow)
                
            }.padding([.top, .leading, .trailing])
            HStack
            {
                Button(action:
                {
                    if (operation != "")
                    {
                        if (num2 != "")
                        {text = text + "0"}
                        else
                        {text = "0"}
                        num2 = text
                    }
                    else
                    {
                        if( num1 != "")
                        {text = text + "0"}
                        num1 = text
                    }
                })
                {Text("0").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    var string:NSString = text as NSString
                    
                    if (!string.contains("."))
                    {
                        if (operation != "")
                        {
                            if (num2 != "")
                            {
                                text = text + "."
                            }
                            num2 = text
                        }
                        else
                        {
                            text = text + "."
                            num1 = text
                        }
                    }
                })
                {Text(".").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    text = "0";
                    num1 = "";
                    num2 = "";
                    operation = "";
                })
                {Text("c").foregroundColor(Color.white)}.padding(.all,20).frame(width: 60, height: 40).background(Color.gray)
                Button(action:
                {
                    if(num2 != "")
                    {
                        text = comput(num1: num1, operation: operation, num2: num2);
                        num1 = text;
                        num2 = "";
                        operation = "/";
                    }
                    else
                    {
                        if(num1 != "")
                        {
                            operation = "/";
                        }
                    }
                })
                {Text("/").foregroundColor(Color.red)}.padding(.all,20).frame(width: 50, height: 40).background(Color.yellow)
                
            }.padding([.top, .leading, .trailing])
            Button(action:
            {
                if(num2 != "")
                {
                    text = comput(num1: num1, operation: operation, num2: num2);
                    num1 = "";
                    num2 = "";
                    operation = "";
                }
                else
                {
                    if(text == "0")
                    {
                        num1 = ""
                    }
                    else
                    {
                        num1 = text
                    }
                }
            })
            {Text("=").foregroundColor(Color.white)}.padding(.all,20).frame(width: 120, height: 40).background(Color.gray)
       }.padding(.bottom,100)
    }
}

func comput(num1:String,operation:String,num2:String) -> String
{
    var sum: Double = 0.0
    switch operation
    {
        case "+":
            sum = (num1 as NSString).doubleValue + (num2 as NSString).doubleValue;
        case "-":
            sum = (num1 as NSString).doubleValue - (num2 as NSString).doubleValue;
        case "*":
            sum = (num1 as NSString).doubleValue * (num2 as NSString).doubleValue;
        case "/":
            sum = (num1 as NSString).doubleValue / (num2 as NSString).doubleValue;
        default:
            sum = 0.0;
    }
    return sum.description;
}

struct Palette: View
{
    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    
    var body: some View
    {
        VStack
        {
            Slider(value: $red, in:0...100).padding(.bottom, 20.0)
            Slider(value: $green, in:0...100).padding(.bottom, 20.0)
            Slider(value: $blue, in:0...100).padding(.bottom, 20.0)
            Text("Red: \(red, specifier: "%.0f") \nGreen: \(green, specifier: "%.0f") \nBlue: \(blue, specifier: "%.0f")").multilineTextAlignment(.leading).lineLimit(4)
                .padding(.all,20)
                .frame(width: 300.0, height: 200)
                .background(Color.init(red: red/100, green: green/100, blue: blue/100))
        }
        .padding(.bottom,100)
    }
}

struct Map: View
{
    @State private var openmap = Openmap(openmap:false)
    @State var manager = CLLocationManager()
    @State var alert = false
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text("Switch on the Map")
                Toggle(" ", isOn: $openmap.openmap).labelsHidden()
            }.padding()
            
            if openmap.openmap
            {
                
                MapView(manager: $manager, alert: $alert).alert(isPresented: $alert)
                {
                    Alert(title: Text("please click OK"))
                }
            }
            else
            {
                Location()
            }
        }
    }
}

struct Openmap
{
    var openmap = false
}

struct Location: View
{
    @StateObject var locationManager = LocationManager()
    
    var userLatitude: String
    {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String
    {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    var body: some View
    {
        VStack
        {
            Text("latitude: \(userLatitude)")
            Text("longitude: \(userLongitude)")
        }
    }
}

struct MapView: UIViewRepresentable
{
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    
    let map = MKMapView()
    
    func makeCoordinator() -> MapView.Coordinator
    {
        return Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView
    {
        let center = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let region = MKCoordinateRegion(center:center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.region = region
        manager.requestWhenInUseAuthorization()
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        return map
    }
    
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>){}
    
    class Coordinator: NSObject, CLLocationManagerDelegate
    {
        var parent : MapView
        init(parent1: MapView)
        {
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
        {
            if status == .denied
            {
                parent.alert.toggle()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {
            let location = locations.last
            let point = MKPointAnnotation()
            let georeader = CLGeocoder()
            georeader.reverseGeocodeLocation(location!)
            {
                (places, err) in
                if err != nil
                {
                    print((err?.localizedDescription)!)
                    return
                }
                let place = places?.first?.locality
                point.title = place
                point.subtitle = "Current"
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
                self.parent.map.addAnnotation(point)
                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                self.parent.map.region = region
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
