#include "ForwardRenderPhase.hpp"
#include "GraphicsManager.hpp"
#include "IPipelineStateManager.hpp"

using namespace My;
using namespace std;

void ForwardRenderPhase::Draw(Frame& frame)
{
    auto& pPipelineState = g_pPipelineStateManager->GetPipelineState("PBR");

    // Set the color shader as the current shader program and set the matrices that it will use for rendering.
    g_pGraphicsManager->SetPipelineState(pPipelineState);
    g_pGraphicsManager->SetShadowMaps(frame);
    g_pGraphicsManager->DrawBatch(frame.batchContexts);
}
