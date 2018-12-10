//
//  PopUpTreatmentViewController.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/9/18.
//

import UIKit

class PopUpTreatmentViewController: UIViewController {

    static var stage: Int?
    static var type = String()
    static var name = String()
    
    let colonTreatments = [0: "The usual treatment is a polypectomy, or removal of a polyp, during a colonoscopy. There is no additional surgery unless the polyp cannot be fully removed.",
                           1: "Surgical removal of the tumor and lymph nodes is usually the only treatment needed.",
                           2: "Surgery is often the first treatment. Patients with stage II colorectal cancer should talk with their doctor about whether more treatment is needed after surgery because some patients receive adjuvant chemotherapy. Adjuvant chemotherapy is treatment after surgery aimed at trying to destroy any remaining cancer cells. However, cure rates for surgery alone are quite good, and there are few benefits of additional treatment for people with this stage of colorectal cancer. Learn more about adjuvant therapy for stage II colorectal cancer. A clinical trial is also an option after surgery.For patients with stage II rectal cancer, radiation therapy is usually given in combination with chemotherapy, either before or after surgery. Additional chemotherapy may be given after surgery as well.",
                           3: "Treatment usually involves surgical removal of the tumor fo llowed by adjuvant chemotherapy. A clinical trial may also an option. For patients with rectal cancer, radiation therapy may be used along with chemotherapy before or after surgery, along with adjuvant chemotherapy."]
    
    let breastTreatments = [0: "Stage 0 cancer means that the cancer is limited to the inside of the milk duct and is a non-invasive cancer. The treatment approaches for these non-invasive breast tumors are often different from the treatment of invasive breast cancer. Stage 0 breast tumors include ductal carcinoma in situ (DCIS)",
                            1: "These breast cancers are still relatively small and either have not spread to the lymph nodes or have spread to only a tiny area in the sentinel lymph node (the first lymph node to which cancer is likely to spread).",
                            2: "Treatment for stages I to III breast cancer usually includes surgery and radiation therapy, often along with chemo or other drug therapies either before or after surgery.",
                            3: "Treatment for stages I to III breast cancer usually includes surgery and radiation therapy, often along with chemo or other drug therapies either before or after surgery."]
    let skinTreatments = "Stage 0 melanomas have not grown deeper than the top layer of the skin (the epidermis). They are usually treated by surgery (wide excision) to remove the melanoma and a small margin of normal skin around it. The removed sample is then sent to a lab to be looked at with a microscope. If cancer cells are seen at the edges of the sample, a repeat excision of the area may be done. Stage I melanoma is treated by wide excision (surgery to remove the melanoma as well as a margin of normal skin around it). The margin of normal skin removed depends on the thickness and location of the melanoma. Wide excision (surgery to remove the melanoma and a margin of normal skin around it) is the standard treatment for stage II melanoma. The amount of normal skin removed depends on the thickness and location of the melanoma. Surgical treatment for stage III melanoma usually requires wide excision of the primary tumor as in earlier stages, along with lymph node dissection. Stage IV melanomas are often hard to cure, as they have already spread to distant lymph nodes or other areas of the body. Skin tumors or enlarged lymph nodes causing symptoms can often be removed by surgery or treated with radiation therapy."
    
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var general: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       typeTitle.text = PopUpTreatmentViewController.name.uppercased()
        if PopUpTreatmentViewController.stage == nil {
            general.text = skinTreatments
        } else {
            if PopUpTreatmentViewController.type == "Colorectal Cancer" {
                general.text = colonTreatments[PopUpTreatmentViewController.stage!]
            }
            else if PopUpTreatmentViewController.type == "Breast Cancer" {
                general.text = breastTreatments[PopUpTreatmentViewController.stage!]
            }
        }
       
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
