
# using Pkg
# Pkg.add("JSON")
# Pkg.add("Luxor")
using Luxor
using JSON
using DataStructures
using Random

macro img(filename, expr)
    quote
        @svg begin
            $(esc(expr))
        end 480 180 $("./graphics/$filename.svg")
    end
end

X, Y = 480, 180

slides = []

macro slide(name, scenario, suggestion, rationale, example_stem, example_answer, graphic_name, graphic)
    quote
        push!($(esc(slides)), Dict("scenario" => $(scenario),
            "suggestion" => $(suggestion),
            "rationale" => $(rationale),
            "example_stem" => $(example_stem),
            "example_answer" => $(example_answer),
            "graphic_name" => $(graphic_name),
            ))
        @img $(graphic_name) begin
            $(esc(graphic))
            end
    end
end

function brain()

    gsave()

    sethue(0.8, 0.7, 0.8)
    ellipse(Point(0,0), 120, 100, :fillstroke)
    circle(0, 25, 35, :fillstroke)
    ellipse(0, 65, 30, 50, :fillstroke)
    box(0, 60, 20, 100, :fillstroke)

#     sethue(1,1,1)
#     fontsize(16)
#     fontface("Helvetica-Bold")
#     text("BRAIN", 0, 0, halign=:center)

    grestore()

end
function pill(starthue :: Tuple{Number, Number, Number}, huescale :: Float64 )

    gsave()


    newpath()
    line(Point(-X/8, -Y/8), Point(X/8, -Y/8))
    arc2r(Point(X/8, 0), Point(X/8, -Y/8), Point(X/8, Y/8))
    line(Point(X/8, Y/8), Point(-X/8, Y/8))
    arc2r(Point(-X/8, 0), Point(-X/8, Y/8), Point(-X/8, -Y/8))
    clip()

    sethue(starthue)
    box(O, 3X/8, 3Y/8, :fill)

    turtle = Turtle(0,0)
    walks = rand!(zeros(500, 5))
    Pencolor(turtle, starthue)
    for i in 1:500
        Forward(turtle, walks[i, 1] * 20)
        Circle(turtle, walks[i, 2]*10)
        Turn(turtle, walks[i, 3] * 100)
        Penwidth(turtle, walks[i, 4] * 4)
        HueShift(turtle, walks[5] * huescale)
    end

    setline(5)
    sethue(1,1,1)
    line(Point(0, -Y/8), Point(0, Y/8), :stroke)


    grestore()
end

function oralmed(starthue :: Tuple{Number, Number, Number}, huescale :: Float64, name :: String, route :: String, dose :: String, when :: String, freq :: String)
    translate(-X/5, -Y/16)
    scale(0.9)
    pill(starthue, huescale)
    scale(1/0.9)
    fontsize(20)
    fontface("Nunito-Bold")
    text(name, O + (0, 50), valign=:middle, halign=:center)
    translate(X/3.5,0)
    fontface("Nunito")
    text(dose, O + (0, -45), valign=:middle)
    text(route, O + (0,-15), valign=:middle)
    text(when, O + (0, 15), valign=:middle)
    text(freq, O + (0, 45), valign=:middle)

end
@img "fluoxetine" begin
    oralmed((0.6, 1.0, 0.6), 4.0, "Fluoxetine", "by mouth", "20mg", "in the morning", "once daily")
end

@img "duloxetine" begin
    oralmed((0.3, 0.3, 0.6), 3.0, "Duloxetine", "by mouth", "60mg", "in the morning", "once daily")
end

@img "mirtazepine" begin
    oralmed((0.95, 0.90, 0.6), 3.0, "Mirtazepine", "by mouth", "15mg", "at night", "once daily")
end

@img "lithium" begin
    oralmed((1.0, 0.8, 0.8), 3.0, "Lithium", "by mouth", "125-500mg", "twice daily, 2 weeks", "then adjust!")
end

@img "valproate" begin
    oralmed((0.7, 0.5, 0.7), 3.0, "Valproate", "by mouth", "200-400mg", "twice daily", "and adjust!")
end

@img "chlorpromazine" begin
    oralmed((1,0.6, 0.3), 3.0, "Chlorpromazine", "by mouth", "200mg", "at night", "daily")
end

@img "clozapine" begin
    oralmed((1, 0.9, 0.7), 5.0, "Clozapine", "by mouth", "12.5-200mg", "at night", "daily")
end


function neurostim(starthue :: Tuple{Number, Number, Number}, huescale :: Float64, name :: String)

    gsave()

    newpath()
    w = Y / 5
    line(O - (1.5w, 2.5w), O - (0.5w, 2.5w))
    line(O - (0.5w, 2.5w), O - (0.5w, 0.5w))
    line(O - (0.5w, 0.5w), O + (1.5w, -0.5w))
    line(O + (1.5w, -0.5w), O + (1.5w, 2.5w))
    line(O + (1.5w, 2.5w), O + (0.5w, 2.5w))
    line(O + (0.5w, 2.5w), O + (0.5w, 0.5w))
    line(O + (0.5w, 0.5w), O + (-1.5w, 0.5w))
    line(O + (-1.5w, 0.5w), O - (1.5w, 2.5w))
    clip()

    sethue(starthue)
    turtle = Turtle(0,0)
    walks = rand!(zeros(500, 5))
    Pencolor(turtle, starthue)
    for i in 1:500
        Forward(turtle, walks[i, 1] * 20)
        Circle(turtle, walks[i, 2]*10)
        Turn(turtle, walks[i, 3] * 100)
        Penwidth(turtle, walks[i, 4] * 4)
        HueShift(turtle, walks[5] * huescale)
    end

    setline(5)
    sethue(1,1,1)
    line(Point(0, -Y/8), Point(0, Y/8), :stroke)


    grestore()

    fontsize(20)
    fontface("Nunito-Bold")
    text(name, O + (0, 50), valign=:middle, halign=:center)
    translate(X/3.5,0)

end

@img "ect" begin
    neurostim((0.5, 0.5, 0.5), 2.0, "ECT")
end

function title(string)
    gsave()
    fontface("Helvetica-Bold")
    fontsize(20)
    sethue(0,0,0)
    text(string, 0, 200, halign=:center)
    grestore()
en



@img "serotonin-source" begin

    translate(-30,-70)

    gsave()
    translate(-50, 0)
    brain()
    grestore()

    r_pin = 5

    circle(-50,60, r_pin,:stroke)
    line(Point(-50+r_pin,60), Point(40,60), :stroke)
    arrow(Point(-50, 60+r_pin), Point(-50, 150))
    arrow(Point(-50, 60-r_pin), Point(-50, 5))

    fontface("Helvetica-Bold")
    fontsize(15)
    text("RAPHE NUCLEI", 50, 60, valign=:middle)
    fontface("Helvetica")
    textwrap("Contains neurons which produce serotonin.", 200, Point(50,70))

    fontsize(13)
    fontface("Helvetica-Bold")
    text("DORSAL HORN", -70, 130, halign=:right)
    fontface("Helvetica")
    text("Suppresses pain.", -70, 150, halign=:right)

    #title("SEROTONIN")

end

function brainside()

    gsave()

    sethue(0.8, 0.7, 0.8)
    ellipse(Point(0,0), 160, 100, :fillstroke)
    circle(40, 15, 50, :fillstroke)
    circle(30, 55, 30, :fillstroke)
    circle(-7.5, 50, 5, :fillstroke)
    ellipse(10, 65, 30, 50, :fillstroke)
    box(20, 60, 20, 100, :fillstroke)

#     sethue(1,1,1)
#     fontsize(16)
#     fontface("Helvetica-Bold")
#     text("BRAIN", 0, 0, halign=:center)

    grestore()

end


@img "dopamine-source" begin

    translate(-70,-40)

    gsave()
    translate(-50, 0)
    brainside()
    grestore()

    r_pin = 3
    fontface("Helvetica-Bold")
    fontsize(15)

    sethue(0.6, 0.3, 0.3)
    hx, hy = -37.5, 30
    circle(hx, hy, r_pin, :stroke)
    arrow(Point(hx-r_pin, hy), Point(hx-22.5, hy+22.5))
    text("4", Point(hx-22.5-10, hy+22.5+10), halign=:right)
    text("4) \"Don't lactate\" pathway", 80, 100)
    fontface("Helvetica")
    text("(tubero-infundibular)", 100, 120)

    sethue(0,0,0)
    snx, sny = -30, 50
    circle(snx, sny,r_pin,:stroke)
    arrow(Point(snx, sny-r_pin), Point(snx, sny-50))
    fontface("Helvetica-Bold")
    text("1", Point(snx, sny-55), valign=:bottom, halign=:center)
    text("1)  Movement pathway", 80, -50)
    fontface("Helvetica")
    text("(nigro-striatal)", 100, -30)

    sethue(0, 0.2, 0.4)
    vtax, vtay = -40, 60
    circle(vtax, vtay, r_pin, :stroke)

    arrow(Point(vtax, vtay-r_pin), Point(vtax, vtay-30), Point(vtax-5, vtay-35), Point(vtax-25, vtay-35))
    fontface("Helvetica-Bold")
    text("3", Point(vtax-30, vtay-35), halign=:right, valign=:middle)
    text("3)  Reward pathway", 80, 50)
    fontface("Helvetica")
    text("(meso-limbic)", 100, 70)

    arrow(Point(vtax, vtay-r_pin), Point(vtax, vtay-60), Point(vtax-20, 0), Point(-125, 0))
    fontface("Helvetica-Bold")
    text("2", Point(-135,0), halign=:right, valign=:middle)
    text("2)  Cognitive pathway", 80, 0)
    fontface("Helvetica")
    text("(meso-cortical)", 100, 20)

    #title("DOPAMINE")

end

function label(main, subtext, xmin, ymin)
    gsave()

    sethue(0,0,0)
    fontsize(15)
    fontface("Helvetica-Bold")
    text(main, xmin, ymin, valign=:middle)

    fontface("Helvetica")
    textwrap(subtext, 200, Point(xmin, ymin+10))

    grestore()
end

@img "noradrenaline-source" begin


    translate(-100,-30)
    brainside()
    r_pin = 5
    circle(30, 65, r_pin, :stroke)
    line(Point(30+r_pin,65), Point(120, 65), :stroke)

    label("LOCUS COERULEUS", "Contains neurons releasing noradrenaline.", 130, 65)

end

function treesplit(root :: String, labels :: OrderedDict{String, String};
                    xscale :: Float64 = 1, yscale :: Float64 = 1, withBg::Bool = true)

    gsave()
    numlabels = length(labels)
    yspacing = 30 * yscale
    xdist = 120 * xscale
    r_pin = 1
    if withBg
        background(0.102, 0.102, 0.110)
    else
        background(0,0,0,0)
    end

    for (i, entry) in enumerate(labels)
        ypos = (i - 0.5 - numlabels / 2) * yspacing
        setcolor(entry[2])
        move(O)
        curve(O + (xdist/2, 0), O + (xdist/2,ypos), O + (xdist, ypos))
        strokepath()
        circle(O + (xdist, ypos), r_pin, :fillstroke)
        fontsize(16)
        text(entry[1], Point(xdist + 10, ypos), valign=:middle)
    end

    sethue(1,1,1)
    fontface("Helvetica-Bold")
    text(root, -5, 0, valign=:middle, halign=:right)
    grestore()

end

@img "antidepressants" begin
    labels = OrderedDict(
        "SSRIs" => "green",
        "TCAs" => "green",
        "MAOIs" => "green",
        "SNRIs" => "blue",
        "NRIs" => "blue",
        "NSSAs" => "blue",
        "Melantonergic agonist" => "blue",
        "α2 antagonist" => "blue",
        "Partial serotonin agonist" => "red",
        "Noradrenaline-Dopamine reuptake inhibitors" => "red",
        "Serotonin agonist/reuptake inhibitor" => "red",
    )
    translate(-100,0)
    treesplit("ANTI-DEPRESSANTS", labels, xscale=1.0, yscale=0.75)
end

@img "mood-stabilisers" begin
    labels = OrderedDict(
        "Lithium" => "green",
        "Sodium valproate" => "green",
        "Carbamazepine" => "blue",
        "Lamotrigine" => "red",
    )
    translate(-100,0)
    treesplit("MOOD STABILISERS", labels, xscale=1.0, yscale=1.0)
end

@img "anti-psychotics" begin
    labels1 = OrderedDict(
        "Typical" => "green",
        "Atypical" => "green",
    )

    yscale = 6.0

    translate(-100,0)
    treesplit("ANTI-PSYCHOTICS", labels1, xscale=0.1, yscale=yscale)


    translate(70,-15 * yscale)
    labels_typical = OrderedDict(
        "Chlorpromazine" => "green",
    )
    treesplit("", labels_typical, xscale=0.3, yscale=1.0)

    translate(0,30 * yscale)
    labels_atypical = OrderedDict(
        "Olanzepine" => "green",
        "Risperidone" => "green",
        "Paliperidone" => "green",
    )
    treesplit("", labels_atypical, xscale=0.3, yscale=1.0)

end

@img "sedatives" begin
    translate(-100, 0)
    labels = OrderedDict(
        "Benzodiazepines" => "green",
        "Zolpidem" => "blue",
        "Zopiclone" => "blue",
    )

    treesplit("SEDATIVES", labels, xscale=0.5, yscale=1.0)


    translate(160, -30)
    labels_benzos = OrderedDict(
        "Midazolam" => "green",
        "Alprazolam" => "green",
        "Oxazepam" => "green",
        "Lorazepam" => "green",
    )

    treesplit("", labels_benzos, xscale=0.5, yscale=1.0)
end

@img "neurostimulation" begin
    labels = OrderedDict(
        "ECT" => "green",
        "Transmagentic stimulation" => "blue",
        "Psychosurgery" => "red"
    )

    treesplit("NEUROSTIMULATION", labels, xscale=1.0, yscale=1.0)
end

@img "psychotherapy" begin
    labels = OrderedDict(
        "CBT" => "blue",
        "Psychodynamic psychotherapy" => "red",
        "Supportive therapy" => "red",
        "Family therapy" => "red",
        "Motivational interviewing" => "red",
        "DBT" => "red",
        "Mentalisation-based therapy" => "red"
    )

    treesplit("PSYCHOTHERAPY", labels, xscale=1.0, yscale=1.0)
end

@img "contents" begin

    translate(-60,0)

    labels = OrderedDict(
        "Biological" => "white",
        "Psychological" => "white",
    )

    treesplit("Ψ Treatments", labels, xscale=0.75, yscale=2.0)


end

@img "biological" begin

    translate(-80,0)

    labels_bio = OrderedDict(
        "Antidepressants" => "white",
        "Mood stabilisers" => "white",
        "Antipsychotics" => "white",
        "Sedatives" => "white",
        "Neurostimulation" => "white",
    )

    treesplit("BIOLOGICAL", labels_bio, xscale=1.0, yscale=1.0)
end

@img "transmitters" begin

    translate(-80,0)

    labels = OrderedDict(
        "Serotonin " => "red",
        "Noradrenaline" => "red",
        "Dopamine" => "red",
        "Acetylcholine" => "white",
        "Histamine" => "white",
        "GABA" => "white",
        "Glutamate" => "white",
    )

    treesplit("NEUROTRANSMITTERS", labels, xscale=1.0, yscale=1.0)

end

apropos("ordered dict")

@img "ssri" begin
    translate(-80, 0)

    labels = OrderedDict(
        "Fluoxetine" => "lightgreen",
        "Paroxetine" => "white",
        "Escitalopram" => "white",
        "Citalopram" => "white",
        "Fluvoxamine" => "white",
        "Sertraline" => "white",
    )

    treesplit("SSRIs", labels, xscale=1.0, yscale=0.8)

end

@img "snri" begin
    translate(-80,0)
    labels = OrderedDict(
        "Duloxetine" => "white",
        "Venlafaxine" => "white",
        "Desvenlafaxine" => "white",
        "Milnacipran" => "grey",
    )

    treesplit("SNRIs", labels, xscale=1.0, yscale=1.0)
end

@img "NaSSA" begin
    translate(-80,0)
    labels = OrderedDict(
        "Mirtazepine" => "lightgreen",
        "Mianserin" => "grey",
    )

    treesplit("NaSSAs", labels, xscale=1.0, yscale=1.0)
end

@img "maoi" begin
    labels = OrderedDict(
        "Non-selective" => "white",
        "MAO-A" => "white",
        "MAO-B" => "white"
    )

    labels_non = OrderedDict(
        "Tranylcypramine" => "white",
        "Phenelzine" => "white",
        "Isocarboxazid" => "grey",
    )

    labels_a = OrderedDict(
        "Moclobemide (reversible)" => "lightgreen",
    )

    labels_b = OrderedDict(
        "Selegiline" => "grey",
    )

    translate(-160,14)
    treesplit("MAOIs", labels, xscale=0.5, yscale=2.0)
    translate(180, -60)
    treesplit("", labels_non, xscale=0.5, yscale=1.0, withBg = false)
    translate(-45, 60)
    treesplit("", labels_a, xscale=0.5, yscale=1.0, withBg = false)
    translate(0, 60)
    treesplit("", labels_b, xscale=0.5, yscale=1.0, withBg = false)
end


@img "tca" begin

    translate(-80, 0)

    labels = OrderedDict(
        "Amitriptyline" => "white",
        "Clomipramine" => "white",
        "Dothiepin" => "white",
        "Doxepin" => "white",
        "Imipramine" => "white",
        "Nortriptyline" => "white",
    )

    treesplit("TCAs", labels, xscale=1.0, yscale=0.8)
end

@img "typicals" begin

    translate(-90,0)

    labels = OrderedDict(
        "Chlorpromazine" => "white",
        "Haloperidol*" => "white",
        "Zuclopenthixol*" => "white",
        "Flupenthixol*" => "gray",
        "Fluphenazine*" => "gray",
        "Pericyazine" => "gray",
    )

    treesplit("FGAs", labels, xscale=0.8, yscale=0.9)


    sethue(1,1,1)
    text("* Has depot form.", 240, 80)
end

@img "atypicals" begin
    translate(-80,0)

    labels = OrderedDict(
        "Amisulpride" => "white",
        "Aripiprazole" => "white",
        "Asenapine" => "grey",
        "Clozapine" => "coral",
        "Olanzapine*" => "white",
        "Paliperidone*" => "white",
        "Quetiapine" => "white",
        "Risperidone*" => "white",
        "Ziprasidone" => "white",
        "Sertindole" => "grey",
    )

    treesplit("SGAs", labels, xscale=0.8, yscale=0.58)
    sethue(1,1,1)
    text("* Has depot form.", 240, 80)
end

@img "bzds" begin

    translate(-170, 0)

    labels = OrderedDict(
        "Very-short acting" => "white",
        "Short-acting" => "white",
        "Medium-acting" => "white",
        "Long-acting" => "white"
    )

    treesplit("BZDs", labels, xscale=0.5, yscale=1.5)

    labels_vs = OrderedDict(
        "Midazolam" => "white"
    )

    labels_s = OrderedDict(
        "Alprazolam" => "white",
        "Oxazepam" => "white",
        "Temazepam" => "white",
    )

    labels_m = OrderedDict(
        "Lorazepam" => "white",
        "Bromazepam" => "grey",
    )

    labels_l = OrderedDict(
        "Clonazepam" => "white",
        "Diazepam" => "white",
    )

    translate(200, 67.5)
    treesplit("", labels_vs, xscale=0.5, yscale=1.0, withBg = false)
    translate(0, 45)
    treesplit("", labels_s, xscale=0.5, yscale=0.5, withBg = false)
    translate(0, 45)
    treesplit("", labels_m, xscale=0.5, yscale=0.5, withBg = false)
    translate(0, 37.5)
    treesplit("", labels_l, xscale=0.5, yscale=0.5, withBg = false)
end
