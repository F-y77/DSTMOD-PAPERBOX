require "prefabutil"
require "recipe"
require "modutil"

local assets=
{
    Asset("ANIM", "anim/paperbox.zip"),
    Asset("ATLAS", "images/inventoryimages/paperbox.xml"),
    Asset("IMAGE", "images/inventoryimages/paperbox.tex"),
}

--------------------------------

local function onopen(inst) 
    inst.AnimState:PlayAnimation("open") 
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end 

local function onclose(inst) 
    inst.AnimState:PlayAnimation("idle") 
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")        
end 

----------------------------------

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
        inst.components.container:Close()
    end
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("closed", false)
end

----------------------------------

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 0.66)

    inst:AddTag("structure")

    inst:AddTag("chest")

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "paperbox.tex" )

    inst.AnimState:SetBank("paperbox")
    inst.AnimState:SetBuild("paperbox")
    inst.AnimState:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end

    STRINGS.CHARACTERS.GENERIC.DESCRIBE.PAPERBOX = "一个快递包装箱，可用锤子无限循环使用。" 

    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")
    inst:AddComponent("workable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("treasurechest")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    return inst
end

return Prefab( "common/paperbox", fn, assets, prefabs),
        MakePlacer( "common/paperbox_placer", "paperbox", "paperbox", "idle" ) 
