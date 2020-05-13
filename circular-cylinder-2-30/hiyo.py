import json
import sys
from math import pi
import matplotlib.pyplot as plt
class Mesh:

    def __init__(self,filepath):
        self.file =open(filepath)

        #find vectors with the velocity in each direction
        self.U=self.skipheader(self.file)

        self.D =self.cylinder()
        with open('data.json', 'w') as outfile:
            json.dump(self.D, outfile)

    def skipheader(self,data):
        #returns a list whose ith element is a list of the ith velocities, in the same order as the points in Points
        xs = []
        ys = []
        zs = []
        print("debug")
        for line in data:
            line = line.strip('(')
            line = line.strip(')')
            line = line.split()
            try:
                line[2]=line[2][:-1]
                line[0] = float(line[0])
                line[1] = float(line[1])
                line[2] = float(line[2])
                xs.append(line[0])
                ys.append(line[1])
                zs.append(line[2])
            except:
                continue
        return [xs,ys ,zs]

    def cylinder(self):

        data=open(r"system\cyl_sizeockMeshDict")
        hex=[]
        for line in data:
            line = line.strip('(')
            line = line.strip(')')
            line=line.split()
            if "hex" in line :
              line[9]=line[9][1::]
              hex.append([int(line[9]),int(line[10])])
        #hex is a list of lists which contain the number of cells in the local x and y directions for each cyl_sizeock
        self.hex=hex
        cyl_length=self.hex[0][0]
        cyl_size=cyl_length*cyl_length
        D={}
        d=[]
        c=[]
        for i in range(cyl_length):
            for j in range(cyl_length):
                pos=cyl_size*0
                d.append([self.U[0][pos+(j*cyl_length)+i],self.U[1][pos+(j*cyl_length)+i]])
            c.extend(d)
            d=[]
            for j in range(cyl_length):
                pos=cyl_size*1
                d.append([self.U[0][pos+(j*cyl_length)+i],self.U[1][pos+(j*cyl_length)+i]])
            d.reverse()
            c.extend(d)
            d = []
            for j in range(cyl_length):
                pos=cyl_size*2
                d.append([self.U[0][pos+(cyl_length*i)+j],self.U[1][pos+(cyl_length*i)+j]])
            d.reverse()
            c.extend(d)
            d = []
            for j in range(cyl_length):
                pos=cyl_size*3
                d.append([self.U[0][pos+(cyl_length*i)+j],self.U[1][pos+(cyl_length*i)+j]])
            d.reverse()
            c.extend(d)
            d = []
            for j in range(cyl_length):
                pos=cyl_size*4
                d.append([self.U[0][pos+(cyl_length*j)+cyl_length-1+i],self.U[1][pos+(cyl_length*j)+cyl_length-1+i]])
            d.reverse()
            c.extend(d)
            d = []
            for j in range(cyl_length):
                pos=cyl_size*5
                d.append([self.U[0][pos+(cyl_length*j)+cyl_length-1+i],self.U[1][pos+(cyl_length*j)+cyl_length-1+i]])
            c.extend(d)
            d = []
            for j in range(cyl_length):
                pos=cyl_size*6
                d.append([self.U[0][pos+(cyl_length*(cyl_length-1-i))+j],self.U[1][pos+(cyl_length*(cyl_length-1-i))+j]])
            c.extend(d)
            d = []
            for j in range(cyl_length):
                pos=cyl_size*7
                d.append([self.U[0][pos+(cyl_length*(cyl_length-1-i))+j],self.U[1][pos+(cyl_length*(cyl_length-1-i))+j]])
            c.extend(d)
            d = []
            D[str(i)]=c
            c=[]

        return D

def velo(M):
    cyl_length = M.hex[0][0]
    total = cyl_length*8
    list = [pi/4,pi/2,3*pi/4]
    output=[]
    temp=[]
    for x in list:
        idx=round(total*x/(2*pi))
        for i in range(cyl_length):
            temp.append(mean(M.D[str(i)][idx], M.D[str(i)][(idx-1)]))
        output.append(temp)
        temp=[]
    return(output)
def mean(o,t):
    out=[]
    for i in range(len(o)):
        out.append(mean2(o[i],t[i]))
    return out
def mean2(o,t):
    return (o+t)/2

def plot(l):
    dist=[x/20 for x in range(1,20)]
    dist.insert(0,0)
    print(dist)
    fig1, ax1 = plt.subplots()
    fig2, ax2 = plt.subplots()

    for angle in l:
        X=[]
        Y=[]
        for x,y in angle:
            X.append(x)
            Y.append(y)
        ## Tangential Velocity u component
        ax1.plot(dist,X)
        ax1.set_title(r'$U_\theta$')
        ax1.legend(['$\pi$/4',r" $\pi$/2 ",'3$\pi$/4'])
        ax1.set_ylabel("m/s")
        ax1.set_xlabel("distance from cylinder wall (m)")
        ## Radial Velocity v component
        ax2.plot(dist,Y)
        ax2.set_title(r'$U_r$')
        ax2.legend(['$\pi$/4', r" $\pi$/2 ", '3$\pi$/4'])
        ax2.set_ylabel("m/s")
        ax2.set_xlabel("distance from cylinder wall (m)")
    plt.show()
def main(argv=None):
    M=Mesh(argv[1])
    l=velo(M)
    plot(l)
if __name__ == "__main__":
    main(sys.argv)