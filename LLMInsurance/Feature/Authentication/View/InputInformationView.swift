//
// InputInformationView.swift
// LLMInsurance
//
// Created by 안홍범 on 6/11/25.
//

import SwiftUI

struct InputInformationView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ScrollView {  // 가입 정보 입력 뷰
                InformationView()
            }
        }
        .background(
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    endTextEditing()
                }
        )
        .navigationTitle("회원 가입")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .frame(maxWidth: 400)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct InformationView: View {
    @StateObject private var viewModel = InputInformationViewModel()
    @FocusState private var focusedField: Field?
    @State private var shakeTrigger: CGFloat = 0
    @State private var showJobSheet = false

    let genderOptions = ["남", "여"]
    let marriedOptions = [false, true]
    let jobOptions = [
        "사무직/행정직", "공무원", "전문직(의사/법조인 등)", "판매/서비스업",
        "생산/기술/제조직", "건설/운수직", "자영업/프리랜서", "농업/어업/임업",
        "학생", "주부/가사", "무직/구직", "기타",
    ]

    enum Field {  // 포커스 관리용 열거형
        case name, phoneNumber, birthDate, gender, isMarried, job
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("인적 사항")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryBlue)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

            // 이름 입력
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                TextField("이름을 입력하세요", text: $viewModel.name)
                    .focused($focusedField, equals: .name)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .phoneNumber
                    }
                    .frame(height: 22)
                    .textInputAutocapitalization(.never)

            }
            .inputFieldStyle(isFocused: focusedField == .name)

            // 휴대폰 번호 입력
            HStack {
                Image(systemName: "phone")
                    .foregroundColor(.gray)
                TextField("휴대폰 번호를 입력하세요", text: $viewModel.phoneNumber)
                    .focused($focusedField, equals: .phoneNumber)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .birthDate
                    }
                    .frame(height: 22)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.phonePad)
                    .onChange(of: viewModel.phoneNumber) {
                        viewModel.phoneNumber = viewModel.phoneNumber.formatPhoneNumber()
                    }
            }
            .inputFieldStyle(isFocused: focusedField == .phoneNumber)

            // 생년월일 입력 - yyyy.mm.dd로 입력(년,월,알 구분되도록)
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
                TextField("생년월일을 입력하세요", text: $viewModel.birthDate)
                    .focused($focusedField, equals: .birthDate)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .gender
                    }
                    .frame(height: 22)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numbersAndPunctuation)
            }
            .inputFieldStyle(isFocused: focusedField == .birthDate)

            // 성별 선택 - Picker(.segmented)
            HStack {
                Text("성별")
                    .padding(.horizontal, 16)
                Picker(
                    selection: $viewModel.gender,
                    label: HStack {
                        Image(
                            systemName: viewModel.gender == "여"
                                ? "figure.stand.dress" : "figure.stand"
                        )
                        .foregroundColor(.gray)
                        Text(viewModel.gender.isEmpty ? "성별을 선택하세요" : viewModel.gender)
                            .foregroundColor(viewModel.gender.isEmpty ? .gray : .primary)
                    }
                ) {
                    ForEach(genderOptions, id: \.self) { gender in
                        Text(gender).tag(gender)
                    }
                }
                .pickerStyle(.segmented)
                .frame(height: 36)
                .onTapGesture {
                    focusedField = .gender
                }
            }

            // 결혼 여부 선택 - Picker(.segmented)
            HStack {
                Text("결혼 여부")
                    .padding(.horizontal, 16)
                Picker(
                    selection: $viewModel.isMarried,
                    label: HStack {
                        Image(systemName: viewModel.isMarried ? "heart.fill" : "heart")
                            .foregroundColor(.gray)
                        Text(viewModel.isMarried ? "기혼" : "미혼")
                            .foregroundColor(viewModel.isMarried ? .primary : .gray)
                    }
                ) {
                    ForEach(marriedOptions, id: \.self) { married in
                        Text(married ? "기혼" : "미혼").tag(married)
                    }
                }
                .pickerStyle(.segmented)
                .frame(height: 36)
                .onTapGesture {
                    focusedField = .isMarried
                }
            }

            // 직업 선택 - 직업 선택 버튼
            Button(action: { showJobSheet = true }) {
                HStack {
                    Image(systemName: "briefcase")
                        .foregroundColor(.gray)
                    Text(viewModel.job.isEmpty ? "직업을 선택하세요" : viewModel.job)
                        .foregroundColor(viewModel.job.isEmpty ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(50)
            }
            .sheet(isPresented: $showJobSheet) {
                NavigationStack {
                    List(jobOptions, id: \.self) { job in
                        Button(job) {
                            viewModel.job = job
                            showJobSheet = false
                        }
                        .foregroundColor(.primary)
                    }
                    .navigationTitle("직업 선택")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }

            // 다음 버튼
            Spacer().frame(height: 32)
            Button(action: {
                viewModel.goToNextView()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                } else {
                    Text("다음")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.primaryBlue)
            .foregroundColor(.white)
            .cornerRadius(50)
        }
        .padding()
        .navigationDestination(isPresented: $viewModel.isNextView) {
            InputDiseaseView()
        }
    }
}

struct InputInformationView_Previews: PreviewProvider {
    static var previews: some View {
        InputInformationView()
    }
}
